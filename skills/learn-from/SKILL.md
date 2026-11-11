---
name: learn-from
description: Turns a YouTube transcript, book, or article into study notes. Detects the source type and picks the matching output format; for articles, uses Heavy Summary or Light Summary mode and asks which one if unspecified. Use when the user attaches or links a transcript, book, or article to learn from, or says "summarize this" or "help me learn this".
---

# Learn From

Read the attached source and produce notes the user can learn from. The format depends on the source type.

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

Drop sponsor reads, greetings, filler, and repeated points. Fix obvious auto-caption mistakes silently; if a passage is too garbled to trust, mark it `[unclear]`.

### Book

Work chapter by chapter so nothing is skimmed. If the book is too long to read in one pass, say which chapters you covered.

1. **Core thesis**, three to five sentences.
2. **Chapter by chapter**: main idea, key points, and the best example of each chapter.
3. **Frameworks and models** the author introduces, with their steps or parts.
4. **Takeaways**: what to do differently after reading.
5. **Quotes worth keeping**, short and exact, with chapter.

### Article

Two modes. If the user did not name one, ask which with `ask_user_choice` (options: Heavy Summary, Light Summary) before writing anything.

**Heavy Summary**: only what the reader must know.
- One-sentence thesis.
- Three to seven bullets, one sentence each.
- Aim for under 10% of the original length. Cut examples, background, and caveats unless the conclusion depends on them.

**Light Summary**: a shorter version of the article that keeps the author's content.
- Same order and structure as the original, with the original headings.
- Aim for 25–35% of the original length.
- Keep every piece of advice, step, number, caveat, and the examples that carry the argument. Keep the author's intent and tone; cut repetition, anecdotes that add nothing, and padding.
- Write it as prose or the author's own list formats, not as a bullet digest.

## Rules for every type

- Stay faithful to the source. Never add outside facts, and never present your own opinion as the author's.
- Keep the author's advice as advice. Do not water it down into vague generalities.
- Write in the language of the user's message; translate if the source is in another language.
- End with one line: source type, mode (articles only), and anything skipped or unclear.
