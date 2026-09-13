-- MYLO ONLINE ALBUM — Supabase setup
-- Run this in Supabase Dashboard → SQL Editor.

create table if not exists public.album_members (
  email text primary key
);

create table if not exists public.folders (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  note text default '',
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

create table if not exists public.photos (
  id uuid primary key default gen_random_uuid(),
  folder_id uuid not null references public.folders(id) on delete cascade,
  storage_path text not null,
  url text not null,
  original_name text,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now()
);

alter table public.album_members enable row level security;
alter table public.folders enable row level security;
alter table public.photos enable row level security;

create or replace function public.is_album_member()
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.album_members m where lower(m.email)=lower(auth.email())); $$;

-- Anyone can view the album. Only allowlisted members can edit it.
drop policy if exists "public read folders" on public.folders;
create policy "public read folders" on public.folders for select using (true);
drop policy if exists "members insert folders" on public.folders;
create policy "members insert folders" on public.folders for insert to authenticated with check (public.is_album_member());
drop policy if exists "members update folders" on public.folders;
create policy "members update folders" on public.folders for update to authenticated using (public.is_album_member()) with check (public.is_album_member());
drop policy if exists "members delete folders" on public.folders;
create policy "members delete folders" on public.folders for delete to authenticated using (public.is_album_member());

drop policy if exists "public read photos" on public.photos;
create policy "public read photos" on public.photos for select using (true);
drop policy if exists "members insert photos" on public.photos;
create policy "members insert photos" on public.photos for insert to authenticated with check (public.is_album_member());
drop policy if exists "members delete photos" on public.photos;
create policy "members delete photos" on public.photos for delete to authenticated using (public.is_album_member());

-- Storage bucket: public reads, member-only writes/deletes.
insert into storage.buckets (id,name,public) values ('album','album',true)
on conflict (id) do update set public=true;

drop policy if exists "public view album images" on storage.objects;
create policy "public view album images" on storage.objects for select using (bucket_id='album');
drop policy if exists "members upload album images" on storage.objects;
create policy "members upload album images" on storage.objects for insert to authenticated with check (bucket_id='album' and public.is_album_member());
drop policy if exists "members delete album images" on storage.objects;
create policy "members delete album images" on storage.objects for delete to authenticated using (bucket_id='album' and public.is_album_member());

-- Starter folders. The bundled starter photos are still served from GitHub.
insert into public.folders (id,title,note) values
('00000000-0000-0000-0000-000000000001','uss 📸','the two of us'),
('00000000-0000-0000-0000-000000000002','sheonme ✨','little details, little chaos'),
('00000000-0000-0000-0000-000000000003','her 🌷','the main character folder')
on conflict (id) do nothing;

-- IMPORTANT: after creating the two accounts, add their emails here.
-- Example:
-- insert into public.album_members(email) values ('you@example.com'),('her@example.com') on conflict do nothing;
