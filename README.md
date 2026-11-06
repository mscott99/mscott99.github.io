# mscott99.github.io

Matthew S. Scott's personal website, served at https://mscott99.github.io.

- `content/index.md`: the home page (Markdown; `<!-- posts -->` marks where the list of posts goes).
- `content/posts/*.md`: posts, each with front matter `title`, `date`, `summary`, optionally `origin` (where it was first published) and `draft: true`. Maths in `$...$` and `$$...$$`, rendered to HTML by KaTeX at build time.
- `static/`: copied as is (`style.css`, `photo.jpg`, `cv.pdf`).
- `cv/quant.typ`: the one-page industry CV, served as `cv.pdf` (no phone); `typst compile cv/quant.typ static/cv.pdf` after editing it. The phone goes in only through the gitignored `cv/private.sh`.
- `cv/academic.typ`: the longer academic CV, not served.
- `build.ts`: the whole build, about 150 lines. Node 22.6 or later runs it directly.

Build locally: `npm ci && node build.ts`, then open `dist/index.html` or run `python3 -m http.server -d dist`.

Deploy: push to `main`; the GitHub Action builds and publishes to GitHub Pages. The site has no client-side JavaScript.
