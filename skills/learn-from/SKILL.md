---
name: learn-from
description: Turns a YouTube transcript, book, or article into study material with simple visuals. Detects the source type; transcripts and books get Explanation or Summary mode (Summary is Heavy or Light), articles get Heavy Summary or Light Summary. Asks for the mode if unspecified. Use when the user attaches or links a transcript, book, or article to learn from, or says "summarize this", "explain this", or "help me learn this".
---

# Learn From

Read the attached source and produce material the user can learn from, with visuals that make the ideas easy to see. Two choices decide the output: the source type (section 1) and the mode (section 2). The visuals follow the same rules for every type (section 4).

## 1. Detect the source type

The user's own words win over detection. Otherwise:

| Type | Signals |
| --- | --- |
| YouTube transcript | youtube.com or youtu.be link, `.srt`/`.vtt` file, timestamps, spoken-style text with filler words, no headings, auto-caption errors |
| Book | PDF or EPUB, chapter structure, tens of thousands of words, the user says "book" |
| Article | Web page link, blog post, essay, newsletter, byline and headings, a few thousand words |

If the type is unclear, ask in one line instead of guessing.

For a YouTube link with no transcript attached, try to fetch the captions (for example `yt-dlp --skip-download --write-auto-subs --sub-format vtt`). If that fails, ask for the transcript.

## 2. Pick the mode

| Type | Modes |
| --- | --- |
| Article | Heavy Summary, Light Summary |
| YouTube transcript, Book | **Explanation**, or **Summary** (Heavy Summary or Light Summary) |

The user's words win: "explain", "teach me" mean Explanation; "summarize", "TL;DR" mean Summary; "heavy" or "light" name the summary mode.

If the mode is not clear, ask before writing anything, with `ask_user_choice`:
- Article: Heavy Summary, Light Summary.
- Transcript or book: Explanation, Summary. If the answer is Summary and heavy or light is still unclear, ask a second question: Heavy Summary, Light Summary.

## 3. Produce the output

### Summary modes (all types)

**Heavy Summary**: only what the reader must know.
- One-sentence thesis.
- Three to seven bullets, one sentence each. For a book: five to ten bullets plus one line per chapter.
- Articles and transcripts: aim for under 10% of the original length. Cut examples, background, and caveats unless the conclusion depends on them.
- Visual: one overview map of the thesis and its main points (section 4).

**Light Summary**: a shorter version that keeps the author's content.
- Same order and structure as the original: the original headings for an article, the chapters for a book, the topics in order for a transcript.
- Articles and transcripts: aim for 25–35% of the original length. Book: a few paragraphs per chapter.
- Keep every piece of advice, step, number, caveat, and the examples that carry the argument. Keep the author's intent and tone; cut repetition, anecdotes that add nothing, and padding.
- Write it as prose or the author's own list formats, not as a bullet digest.
- Visual: an overview map plus a small sketch for each section, topic, or chapter's main concept (section 4).

### Explanation mode (transcripts and books)

Teach the source so the user ends up with its applicable knowledge, as if they had consumed all of it. Write for a beginner: plain headings, no jargon before it is explained.

**YouTube transcript**
1. **Topic and speaker**, one line, then the **main idea** in one or two sentences.
2. **Key concepts**, in the order a beginner should learn them. For each: what it means in plain words, why the speaker says it matters, and the speaker's example. Add the timestamp when the transcript has one.
3. **Advice and actions** the speaker recommends.
4. **Visuals** (section 4): an overview map, then a small sketch for each key concept.
5. If the transcript is very long, split it into parts and teach one part per turn, ending each with "Next part" or "Go slower on X".

Drop sponsor reads, greetings, filler, and repeated points. Fix obvious auto-caption mistakes silently; if a passage is too garbled to trust, mark it `[unclear]`.

**Book**: learn a little at a time.

First turn:
1. Read the whole book first, chapter by chapter, so nothing is skimmed. For a PDF or EPUB, extract it to text in a scratch folder and read it in pieces.
2. Show a lesson plan: 4–8 lessons, each mapped to chapters, one line per lesson.
3. Teach Lesson 1 in the same turn. Do not wait for approval of the plan.

Every lesson, one per turn:
- **Teaching text**, about 1,000–1,400 words. Short exact quotes from the book with the chapter.
- **A visual the user can play with** (section 4). Make it interactive, with toggles or clicks that show the idea changing, plus a "Lesson N of M" roadmap. One page per lesson; never overwrite an earlier lesson.
- **Your move**: three concrete things to check in the user's own work.
- A closing check-in: ask whether it landed, and offer "Next lesson" and "Go slower on X".

Examples:
- Programming books: use React Native (TSX) examples from Lesson 1, even when the book uses another language. Keep the book's idea and translate its examples.
- Other books: use everyday situations, not the book's own jargon.

When the user is confused, do not repeat the same explanation. Use a different example, answer their exact question first, and update the lesson's visual in place.

## 4. Visuals

Every type and mode gets visuals. The user learns faster from a picture of the idea than from a paragraph about it.

- **Overview map first.** One picture of how the source's ideas connect: a loop, a sequence, a hierarchy, or a before/after. For a transcript or a long article, add the suggested study order.
- **How many sketches** depends on the mode: Heavy Summary gets the overview map only; Light Summary and transcript Explanation get one sketch per section or key concept; book Explanation gets one lab per lesson. Each sketch shows one idea: a comparison, a flow, a fan-out, a loop, a count. Add one or two lines of text beside it, not a paragraph.
- **Static by default.** Make it interactive only when toggling shows the idea better, such as "with this design vs without". Book lessons use interactive labs; everything else usually does not need them.
- **Keep it simple and calm.** Mostly gray, one accent color on the thing the diagram is about, small readable text, no boxes around prose. Rows of "text on the left, sketch on the right" that stack on narrow screens work well.
- **Build** each page as a self-contained HTML file with inline SVG (in Amp, a visual artifact, embedded in the reply). Group by reading order, about three to five concepts per page, so no page gets long.
- **Check before sharing**: open it at phone (360px) and desktop widths, in light and dark if the host supports it, and fix console errors or clipped text.
- **No invented content.** A sketch shows only what the source says; if the source is vague on a detail, draw it vague or leave it out.
- **Use the host's diagram tools** (in Amp, the `creating-views` skill) when available. If the host cannot render HTML, use a compact text diagram instead.

## Rules for every type

- Stay faithful to the source. Never add outside facts, and never present your own opinion as the author's.
- Keep the author's advice as advice. Do not water it down into vague generalities.
- Write in the language of the user's message; translate if the source is in another language.
- End with one line: source type, mode, and anything skipped or unclear.
