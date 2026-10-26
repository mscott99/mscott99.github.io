# mscott99.github.io

Matthew S. Scott's personal website, served at https://mscott99.github.io.

- `content/index.md`: the home page (Markdown; `<!-- posts -->` marks where the list of posts goes).
- `content/posts/*.md`: posts, each with front matter `title`, `date`, `summary`, optionally `origin` (where it was first published) and `draft: true`. Maths in `$...$` and `$$...$$`, rendered to HTML by KaTeX at build time.
- `static/`: copied as is (`style.css`, `photo.jpg`, `cv.pdf`).
- `cv/cv.typ`: the full CV; `typst compile cv/cv.typ static/cv.pdf` after editing it.
- `build.ts`: the whole build, about 150 lines. Node 22.6 or later runs it directly.

Build locally: `npm ci && node build.ts`, then open `dist/index.html` or run `python3 -m http.server -d dist`.

Deploy: push to `main`; the GitHub Action builds and publishes to GitHub Pages. The site has no client-side JavaScript.
