#import "@preview/minimalistic-latex-cv:0.1.0": cv

// Full CV for the website: neutral, all information, no phone or address.

// Old two-line entry (title/date, then institution/location); kept for the longer version.
#let entry(title: "", name: "", date: "", location: "") = {
  grid(
    columns: (1fr, auto),
    row-gutter: 6pt,
    text(weight: "bold", title), align(end, date),
    text(style: "italic", name), align(end, text(style: "italic", location)),
  )
  v(-3pt)
}
// Compact one-line entry: *title*, _institution_, location ... date.
#let row(title, name, date, location: none, note: none, desc: none) = {
  grid(
    columns: (1fr, auto), column-gutter: 1em,
    [*#title*, #emph(name)#if location != none [, #location]#if desc != none [: #desc]], align(end, date),
  )
  if note != none { v(-6pt); block(inset: (left: 1em), note) }
}
#show: cv.with(
  name: "Matthew S. Scott",
  metadata: (
    // address: "2509 Melfa Lane, Vancouver",
    email: "matthewscott@math.ubc.ca",
    github: link("https://github.com/mscott99")[#underline[github.com/mscott99]],
    website: link("https://mscott99.github.io")[#underline[mscott99.github.io]],
    linkedin: link("https://www.linkedin.com/in/matthew-scott-4387a3138/")[#underline[LinkedIn]],
    languages: "Fluent in English and French",
  ),
  // photo: image("photo.jpeg"),
  lang: "en",
)
#set block(spacing: 1em)
= Education

#row("PhD in Mathematics", "University of British Columbia", "2023-2027 (expected)", note: [Supervisors: Yaniv Plan, Özgür Yılmaz])

#row("MSc in Mathematics", "University of British Columbia", "2021-2023", note: [Thesis: _Generative Compressed Sensing with Fourier Measurements_. Grade average 92%.])

#row("BSc, Joint Honours Mathematics and Physics", "McGill University", "2017-2021", note: [First Class Honours; minor in Computer Science; GPA 3.89/4.00.])

#row("DEC, Honours Pure and Applied Science", "Marianopolis College", "2015-2017", location: "Montreal")

= Publications
- Y. Plan, *M. S. Scott*, O. Yilmaz, _Exact signal recovery from generative priors with sigmoid output activation_, Sampling Theory, Signal Processing, and Data Analysis, submitted.
- *M. S. Scott*, #link("https://arxiv.org/abs/2609.05775")[_Convexity from order: a theory of faces and generalized separation_], J. Convex Analysis, submitted.
- Y. Plan, *M. S. Scott*, O. Yilmaz, #link("https://arxiv.org/abs/2604.04802")[_Partially deterministic sampling for compressed sensing with denoising guarantees_], Information and Inference (IMA), submitted.
- M. P. Friedlander, S. Kubal, Y. Plan, *M. S. Scott*, #link("https://arxiv.org/abs/2510.13083")[_Average-case thresholds for exact regularization of linear programs_], SIAM J. Optimization, second round of revisions.
- *M. S. Scott*, #link("https://arxiv.org/abs/2510.12244")[_Bilateral facial reduction: qualification-free subdifferential calculus and exact duality_], Set-Valued and Variational Analysis, major revisions.
- Y. Plan, *M. S. Scott*, X. Sheng, O. Yilmaz, #link("https://arxiv.org/abs/2504.01046")[_Denoising guarantees for optimized sampling schemes in compressed sensing_], SIAM J. Mathematics of Data Science, 2026.
- A. Berk, S. Brugiapaglia, Y. Plan, *M. S. Scott*, X. Sheng, O. Yilmaz, _Model-adapted Fourier sampling for generative compressed sensing_, NeurIPS 2023 Workshop on Deep Learning and Inverse Problems, oral (6 of 39).
- A. Berk, S. Brugiapaglia, B. Joshi, Y. Plan, *M. S. Scott*, O. Yilmaz, #link("https://arxiv.org/abs/2207.09340")[_A coherence parameter characterizing generative compressed sensing with Fourier measurements_], IEEE J. Selected Areas in Information Theory, 2022.

= Experience

#row("Instructor, Teaching and Research Assistant", "University of British Columbia", "2021-present")
- Instructor of record: MATH 180 (Fall 2024), MATH 100 (Fall 2025), MATH 180 (Fall 2026).
- Research in generative compressed sensing, high-dimensional probability and convex analysis; numerics in Julia.
- Teaching assistant: grading and tutoring in the Math Learning Centre.

#row("Freelance Tutor", "Superprof", "2020-2021", location: "Montreal")
- Rated 4.87/5 over 15 reviews. Earlier: math tutor at Paramount Study School (2017) and Collège Notre-Dame (2015).

#row("Research Assistant in Computer Science", "McGill University (Prakash Panangaden)", "Summer 2020")
- Adapted Yaida's fluctuation-dissipation learning-rate method to actor-critic reinforcement learning (PyTorch); proved results and improved performance. Funded by an NSERC USRA.

#row("Machine Learning Intern", "Decathlon Canada", "Summer 2018", location: "Montreal")
- Built a recurrent-network sales forecaster that beat 4 of 5 in-house models, the only one predicting long term.
- Built a Python (Flask) API ranking sport popularity from Google search data.

#row("Web Application Developer", "GoRush", "Summer 2017", location: "Montreal")
- Sole developer of an on-demand lawn-mowing app (JavaScript, Meteor, MongoDB).

= Software projects
- #link("https://github.com/mscott99/Latex-Exporter")[*Latex Exporter*] (TypeScript, 5k lines): Obsidian plugin that compiles a graph of linked Markdown notes (embeds, citations, theorems, cross-references) into one LaTeX paper; 4,700+ downloads, 44 GitHub stars, test suite.
- *Research numerics* (Julia, Flux.jl; Python): generative priors (VAEs) and signal-recovery experiments for the compressed-sensing papers; batch pipelines on Slurm clusters. Packages GenerativeRecoveries.jl, VaeModels.jl.
- *Cracker Craft* (2016; C\#, Unity, Blender): Android fireworks game, 10,000+ downloads on Google Play.
- *Machinations* (2021): turn-based multiplayer duelling game.
- *Line-following robot* (2015): PID control in C on an Arduino, with its electronics.
- #link("https://www.youtube.com/watch?v=8VHjDtwmsbE")[Animated video] explaining the Legendre transform (2022).

= Awards
- UBC Graduate Departmental Award, 2021 and 2022.
- NSERC Undergraduate Student Research Award, 2020.
- Ernest Fox Award for Excellence in Mathematics, Marianopolis College, 2017 (one graduating student per year).
- Robohacks 2017: Best CEGEP and Most Imaginative Robot. McGameJam 2017: Special Mention.
- Canadian Computing Competition, top 25%, 2016 and 2017.
- Fermat Math Contest, school champion, 2015. AMQ Math Competition, 7th of 161, 2014.

= Talks
- _Qualification-free duality via reduction to the joint supporting subspace_, West Coast Optimization Meeting, UW Tacoma, 2026.
- _Denoising guarantees for optimized sampling_, 5th Biennial SIAM Pacific Northwest Meeting, UW Seattle, 2025.
- _Exact regularization of linear programs_, 5th Biennial SIAM Pacific Northwest Meeting, UW Seattle, 2025.
- _Model-adapted Fourier sampling for generative compressed sensing_, NeurIPS Workshop on Deep Learning and Inverse Problems, New Orleans, 2023 (oral).
- _Generative recovery from subsampled Fourier measurements_, CMS Winter Meeting, Montreal, 2023; UBC MILD seminar, 2022.
- Group talks: terminal embeddings (2022-23); convex sets and faces, optimal transport and conic duality (2026).

= Service
- Referee, Journal of Optimization Theory and Applications (2026).
- Workshop on Obsidian and Zettelkasten note-taking for research, UBC Institute of Applied Mathematics (talk 2022, workshop 2024).

= Skills
- *Mathematics:* high-dimensional probability and statistics, random matrices, convex optimization and duality, compressed sensing, geometry and expressivity of neural networks.
- *Programming:* Python (PyTorch, NumPy, Flask), Julia (Flux.jl), TypeScript/JavaScript, C\#, Java; Git, Linux, Slurm, LaTeX, Typst.

= Interests
- Singing (choirs, an a cappella group), acting (the musical _First Date_), Jiu-Jitsu.
