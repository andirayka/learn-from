---
name: learn-from
description: Turns a YouTube transcript, book, or article into study notes with simple visuals. Detects the source type and picks the matching output format; for articles, uses Heavy Summary or Light Summary mode and asks which one if unspecified. Use when the user attaches or links a transcript, book, or article to learn from, or says "summarize this" or "help me learn this".
---

# Learn From

Read the attached source and produce notes the user can learn from, with visuals that make the ideas easy to see. The format depends on the source type; the visuals follow the same rules for every type (section 3).

## 1. Detect the source type

The user's own words win over detection. Otherwise:

| Type | Signals |
| --- | --- |
| YouTube transcript | youtube.com or youtu.be link, `.srt`/`.vtt` file, timestamps, spoken-style text with filler words, no headings, auto-caption errors |
| Book | PDF or EPUB, chapter structure, tens of thousands of words, the user says "book" |
| Article | Web page link, blog post, essay, newsletter, byline and headings, a few thousand words |

If the type is unclear, ask in one line instead of guessing.

For a YouTube link with no transcript attached, try to fetch the captions (for example `yt-dlp --skip-download --write-auto-subs --sub-format vtt`). If that fails, ask for the transcript.

## 2. Produce the output

### YouTube transcript

1. **Topic and speaker**, one line.
2. **Main idea**, one or two sentences.
3. **Key points**, grouped by theme, each with the timestamp when the transcript has one.
4. **Advice and actions** the speaker recommends.
5. **Examples and stories** worth remembering, one line each.
6. **Visuals** (section 3): one overview map, then a small sketch for each key concept.

Drop sponsor reads, greetings, filler, and repeated points. Fix obvious auto-caption mistakes silently; if a passage is too garbled to trust, mark it `[unclear]`.

### Book

The goal: the user ends up with the book's applicable knowledge, as if they had read all of it, learning a little at a time.

**First turn**
1. Read the whole book first, chapter by chapter, so nothing is skimmed. For a PDF or EPUB, extract it to text in a scratch folder and read it in pieces.
2. Show a lesson plan: 4–8 lessons, each mapped to chapters, one line per lesson.
3. Teach Lesson 1 in the same turn. Do not wait for approval of the plan.

**Every lesson**, one per turn:
- **Teaching text**, about 1,000–1,400 words, written for a beginner. Plain headings, no jargon before it is explained, short exact quotes from the book with the chapter.
- **A visual the user can play with** (section 3). Make it interactive, with toggles or clicks that show the idea changing, plus a "Lesson N of M" roadmap. One page per lesson; never overwrite an earlier lesson.
- **Your move**: three concrete things to check in the user's own work.
- A closing check-in: ask whether it landed, and offer "Next lesson" and "Go slower on X".

**Examples**
- Programming books: use React Native (TSX) examples from Lesson 1, even when the book uses another language. Keep the book's idea and translate its examples.
- Other books: use everyday situations, not the book's own jargon.

**When the user is confused**, do not repeat the same explanation. Use a different example, answer their exact question first, and update the lesson's visual in place.

### Article

Two modes. If the user did not name one, ask which with `ask_user_choice` (options: Heavy Summary, Light Summary) before writing anything.

**Heavy Summary**: only what the reader must know.
- One-sentence thesis.
- Three to seven bullets, one sentence each.
- Aim for under 10% of the original length. Cut examples, background, and caveats unless the conclusion depends on them.
- Visual: one overview map of the thesis and its main points (section 3).

**Light Summary**: a shorter version of the article that keeps the author's content.
- Same order and structure as the original, with the original headings.
- Aim for 25–35% of the original length.
- Keep every piece of advice, step, number, caveat, and the examples that carry the argument. Keep the author's intent and tone; cut repetition, anecdotes that add nothing, and padding.
- Write it as prose or the author's own list formats, not as a bullet digest.
- Visual: a small sketch for each section's main concept, plus an overview map (section 3).

## 3. Visuals

Every type gets visuals. The user learns faster from a picture of the idea than from a paragraph about it.

- **Overview map first.** One picture of how the source's ideas connect: a loop, a sequence, a hierarchy, or a before/after. For a transcript or a long article, add the suggested study order.
- **One sketch per key concept** (per section for articles, per lesson for books). Each sketch shows one idea: a comparison, a flow, a fan-out, a loop, a count. Add one or two lines of text beside it, not a paragraph.
- **Static by default.** Make it interactive only when toggling shows the idea better, such as "with this design vs without". Books use interactive labs; transcripts and articles usually do not need them.
- **Keep it simple and calm.** Mostly gray, one accent color on the thing the diagram is about, small readable text, no boxes around prose. Rows of "text on the left, sketch on the right" that stack on narrow screens work well.
- **Build** each page as a self-contained HTML file with inline SVG (in Amp, a visual artifact, embedded in the reply). Group by reading order, about three to five concepts per page, so no page gets long.
- **Check before sharing**: open it at phone (360px) and desktop widths, in light and dark if the host supports it, and fix console errors or clipped text.
- **No invented content.** A sketch shows only what the source says; if the source is vague on a detail, draw it vague or leave it out.
- **Use the host's diagram tools** (in Amp, the `creating-views` skill) when available. If the host cannot render HTML, use a compact text diagram instead.

## Rules for every type

- Stay faithful to the source. Never add outside facts, and never present your own opinion as the author's.
- Keep the author's advice as advice. Do not water it down into vague generalities.
- Write in the language of the user's message; translate if the source is in another language.
- End with one line: source type, mode (articles only), and anything skipped or unclear.
