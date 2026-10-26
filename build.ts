// Builds the site into dist/. Run with `node build.ts` (Node 22.6+ runs TypeScript directly).
// Content: content/index.md (home page), content/posts/*.md (writing), static/ (copied as is).
import { readFileSync, writeFileSync, mkdirSync, readdirSync, cpSync, rmSync, existsSync } from "node:fs";
import { join, basename } from "node:path";
import { Marked } from "marked";
import katex from "katex";

const OUT = "dist";
const SITE = "Matthew S. Scott";
const URL = "https://mscott99.github.io/";

type Meta = Record<string, string>;
type Post = { slug: string; meta: Meta; body: string };

// Front matter: a block of `key: value` lines between `---` lines.
function frontMatter(src: string): { meta: Meta; body: string } {
  const m = src.match(/^---\n([\s\S]*?)\n---\n/);
  if (!m) return { meta: {}, body: src };
  const meta: Meta = {};
  for (const line of m[1].split("\n")) {
    const i = line.indexOf(":");
    if (i > 0) meta[line.slice(0, i).trim()] = line.slice(i + 1).trim();
  }
  return { meta, body: src.slice(m[0].length) };
}

function tex(s: string, display: boolean): string {
  return katex.renderToString(s, { displayMode: display, throwOnError: false, strict: false });
}

// Math: $$...$$ (display, may span lines) and $...$ (inline), read before any other markdown rule
// so that underscores and backslashes inside formulas are left alone.
const marked = new Marked({
  extensions: [
    {
      name: "displayMath", level: "block",
      start: (s: string) => s.match(/^\$\$/m)?.index,
      tokenizer(s: string) {
        const m = s.match(/^\$\$((?:(?!\$\$)[\s\S])+)\$\$[ \t]*(?:\n|$)/);
        if (m) return { type: "displayMath", raw: m[0], text: m[1] };
      },
      renderer: (t: any) => `<div class="math">${tex(t.text, true)}</div>\n`,
    },
    {
      name: "inlineDisplayMath", level: "inline",
      start: (s: string) => s.indexOf("$$"),
      tokenizer(s: string) {
        const m = s.match(/^\$\$((?:(?!\$\$)[\s\S])+)\$\$/);
        if (m) return { type: "inlineDisplayMath", raw: m[0], text: m[1] };
      },
      renderer: (t: any) => `<span class="math">${tex(t.text, true)}</span>`,
    },
    {
      name: "inlineMath", level: "inline",
      start: (s: string) => s.indexOf("$"),
      tokenizer(s: string) {
        const m = s.match(/^\$(?!\s)((?:\\.|[^$\\])+?)\$/);
        if (m) return { type: "inlineMath", raw: m[0], text: m[1] };
      },
      renderer: (t: any) => tex(t.text, false),
    },
  ],
});

const md = (s: string) => marked.parse(s) as string;
const esc = (s: string) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

function fmtDate(d: string): string {
  const t = new Date(d + "T12:00:00Z");
  return t.toLocaleDateString("en-GB", { day: "numeric", month: "long", year: "numeric", timeZone: "UTC" });
}

function page(title: string, body: string, opts: { root: string; path: string; math?: boolean; description?: string }): string {
  const r = opts.root;
  const url = URL + opts.path;
  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)}</title>
${opts.description ? `<meta name="description" content="${esc(opts.description)}">` : ""}
<link rel="canonical" href="${url}">
<link rel="icon" href="${r}favicon.png">
<meta property="og:title" content="${esc(title)}">
<meta property="og:url" content="${url}">
<meta property="og:image" content="${URL}photo.jpg">
${opts.description ? `<meta property="og:description" content="${esc(opts.description)}">` : ""}
<link rel="stylesheet" href="${r}style.css">
${opts.math ? `<link rel="stylesheet" href="${r}katex/katex.min.css">` : ""}
</head>
<body>
<header class="site">
  <a class="name" href="${r}">${SITE}</a>
  <nav>
    <a href="${r}#writing">Writing</a>
    <a href="${r}#research">Research</a>
    <a href="${r}cv.pdf">CV</a>
  </nav>
</header>
<main>
${body}
</main>
<footer>&copy; ${new Date().getUTCFullYear()} Matthew S. Scott &middot; <a href="mailto:matthewscott@math.ubc.ca">matthewscott@math.ubc.ca</a></footer>
</body>
</html>
`;
}

function readPosts(): Post[] {
  const dir = "content/posts";
  return readdirSync(dir)
    .filter((f) => f.endsWith(".md"))
    .map((f) => {
      const { meta, body } = frontMatter(readFileSync(join(dir, f), "utf8"));
      return { slug: basename(f, ".md"), meta, body };
    })
    .filter((p) => p.meta.draft !== "true")
    .sort((a, b) => (b.meta.date ?? "").localeCompare(a.meta.date ?? ""));
}

function postList(posts: Post[]): string {
  const items = posts.map((p) => `<li>
  <a class="title" href="posts/${p.slug}/">${esc(p.meta.title)}</a> <span class="date">${fmtDate(p.meta.date)}</span>
  ${p.meta.summary ? `<p>${esc(p.meta.summary)}</p>` : ""}
</li>`);
  return `<ul class="posts">\n${items.join("\n")}\n</ul>`;
}

function build() {
  rmSync(OUT, { recursive: true, force: true });
  mkdirSync(OUT, { recursive: true });
  cpSync("static", OUT, { recursive: true });
  const kd = "node_modules/katex/dist";
  mkdirSync(join(OUT, "katex"), { recursive: true });
  cpSync(join(kd, "katex.min.css"), join(OUT, "katex/katex.min.css"));
  cpSync(join(kd, "fonts"), join(OUT, "katex/fonts"), { recursive: true });

  const posts = readPosts();
  for (const p of posts) {
    const origin = p.meta.origin
      ? `<p class="origin">Also published on the <a href="${esc(p.meta.origin)}">UBC Optimization Group blog</a>.</p>`
      : "";
    const body = `<article>
<h1>${esc(p.meta.title)}</h1>
<p class="date">${fmtDate(p.meta.date)}</p>
${origin}
${md(p.body)}
</article>`;
    const dir = join(OUT, "posts", p.slug);
    mkdirSync(dir, { recursive: true });
    writeFileSync(join(dir, "index.html"), page(`${p.meta.title} | ${SITE}`, body, { root: "../../", path: `posts/${p.slug}/`, math: true, description: p.meta.summary }));
  }

  const { meta, body } = frontMatter(readFileSync("content/index.md", "utf8"));
  const home = md(body).replace("<p><!-- posts --></p>", postList(posts)).replace("<!-- posts -->", postList(posts));
  writeFileSync(join(OUT, "index.html"), page(SITE, home, { root: "", path: "", math: true, description: meta.description }));
  writeFileSync(join(OUT, "404.html"), page(`Not found | ${SITE}`, `<h1>Not found</h1><p><a href="/">Home</a></p>`, { root: "/", path: "404.html" }));
  writeFileSync(join(OUT, ".nojekyll"), "");
  console.log(`built ${posts.length} posts into ${OUT}/`);
}

if (!existsSync("content/index.md")) throw new Error("run from the repository root");
build();
