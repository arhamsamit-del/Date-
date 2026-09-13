MYLO — AMATEUR EDITION

What changed
1. Replaced the landing-page placeholder photos with photos from the supplied ZIP.
2. Added more photos across the remaining date pages.
3. Fixed the gallery links so index.html -> gallery.html works.
4. Added gallery.html with three requested folders:
   - uss
   - sheonme
   - her
5. Added a simple click-to-enlarge photo view.
6. Kept the design intentionally handmade/amateur: scrapbook feel, polaroids, casual labels, no heavy framework.

Folder structure
index.html
gallery.html
images/
  photo1.jpg ... photo5.jpg
  uss/
  sheonme/
  her/

Open index.html to start.

EDITABLE GALLERY
The gallery.html page now has a browser-based editor:
- Create new folders
- Rename folders
- Delete folders
- Add multiple photos to any folder from the device
- Delete individual photos
- Changes persist in localStorage for that browser/device
- Reset restores the original bundled album

Important: browsers cannot normally rewrite files inside the extracted ZIP. Added photos are therefore stored in the browser's localStorage as data URLs rather than being copied into the ZIP's images folders.
