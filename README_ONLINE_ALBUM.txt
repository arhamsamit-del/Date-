MYLO — GITHUB PAGES + SUPABASE ONLINE ALBUM

WHAT CHANGED
- GitHub Pages still hosts index.html and gallery.html.
- Supabase stores folders, online uploads and edits.
- Anyone can view the album.
- Only emails listed in Supabase's album_members table can create/rename/delete folders or upload/delete photos.
- Existing starter photos remain bundled with the website. New photos are stored online in Supabase Storage and are visible from any device.

SETUP
1. Create a Supabase project.
2. Open SQL Editor and paste/run supabase_setup.sql.
3. In Authentication → Users, create two email/password users (one for you and one for her), or use your preferred Supabase Auth flow.
4. Run:
   insert into public.album_members(email) values ('YOUR_EMAIL'),('HER_EMAIL') on conflict do nothing;
5. Open Project Settings → API and copy the Project URL and the publishable/anon key.
6. Put them in config.js:
   window.MYLO_SUPABASE_URL = 'https://YOURPROJECT.supabase.co';
   window.MYLO_SUPABASE_KEY = 'YOUR_PUBLISHABLE_KEY';
   NEVER use a service_role/secret key in the browser.
7. Upload the whole folder to GitHub and enable GitHub Pages from main/root.

HOW TO USE
- Open gallery.html.
- Viewers do not need an account.
- Click Sign in with an allowlisted email to edit.
- New folder / Rename / Delete / Add photos work online.
- Uploaded images go to the Supabase Storage bucket named album.
- Folder/photo metadata is stored in Postgres.

IMPORTANT
The GitHub repository is public if you use GitHub Free public Pages. Do not put passwords, service_role keys, or other secrets in the repository. The browser-safe Supabase publishable/anon key is designed to be exposed; Row Level Security is what protects the database.
