---
name: learn-from
description: Turns a YouTube transcript, book, or article into study material with visuals, as a full explanation or as a heavy or light summary. Use when the user gives a YouTube link, transcript, book, or article and asks to learn from it, explain it, or summarize it.
---

# Learn From

Turn the source into material the user can learn from, with visuals that show the ideas. The learner is a React Native developer who wants knowledge they can apply. Write for a beginner: plain words, and no jargon before it is explained.

Write in the language the user writes in, and keep quotes in the source's language. Quote the source only word for word: search the source text for each quote before using it, and paraphrase without quotation marks when the search does not find it.

## Modes

- **Explanation** (transcripts and books): teach the source in full, so the user ends up with its applicable knowledge as if they had consumed all of it.
- **Heavy Summary**: only what the reader must know. A one-sentence thesis, then a few one-sentence bullets. For an article or transcript, stay under 10% of the original length. Cut examples, background, and caveats unless the conclusion depends on them.
- **Light Summary**: a shorter version that keeps the author's content. Follow the original order, and merge neighbouring sections, chapters, or topics that cover the same idea. Keep every piece of advice, step, number, and caveat, the examples that carry the argument, and the author's tone. For an article or transcript, aim for 25–35% of the original length; for a book, a few paragraphs per section. Write prose or the author's own list formats, not a bullet digest.

The user's words decide the mode. When they name none, a transcript or book gets Explanation and an article gets Light Summary. When they ask for a summary of a transcript or book without saying heavy or light, ask with `ask_user_choice`.

If you cannot tell whether the source is a transcript, a book, or an article, ask in one line. A YouTube link counts as a transcript source: get the transcript yourself, as below, and do not ask the user for it unless that fails.

## Getting a transcript from a YouTube link

Run the script in this skill's folder. It prints the video's own captions (creator subtitles, else auto-generated) as `[m:ss] text` lines:

```sh
scripts/youtube-transcript.sh "<url>" [language-code]
```

The language defaults to `en`; for a video in another language, pass its code. If `yt-dlp` is missing, install it (`brew install yt-dlp`) and run again. If the error mentions HTTP 429, wait a minute and run again.

If the script still exits without captions (none exist, or the video is private, members-only, or age-restricted), say so and ask the user for the transcript. Teach only from a transcript, never from the title.

## Explaining a transcript

Teach the key concepts in the order a beginner should learn them, which need not be the video's order. For each concept, give what it means in plain words, why the speaker says it matters, and the speaker's example, with the timestamp when the transcript has one. Then list the advice and actions the speaker recommends. The explanation is done when every piece of advice, step, and number in the transcript appears in it. End the turn with the practice block below.

Leave out sponsor reads, greetings, filler, and repeated points. Fix obvious auto-caption mistakes silently, and mark a passage too garbled to trust as `[unclear]`. Teach a very long transcript one part per turn.

## Explaining a book

Teach the book as lessons, one per turn.

A book takes many turns, often across several threads, so keep the course on disk in `~/.learn-from/<book-slug>/`:

- `chapters/`: the book's text, one file per chapter, written once when you first read the book.
- `course.md`: the path of the source file, the lesson plan with the chapters each lesson covers, which lessons are taught and where their pages are, and the ideas the user got wrong or skipped in "Check yourself".

Before anything else, look for the book's `course.md`. If it exists, do not reread the book or plan again: read `course.md` and the chapter files of the next lesson, and continue from there. Update `course.md` after each lesson and after each set of answers from the user.

In the first turn, read the whole book, then show a plan of 4–8 lessons with one line each and the chapters each lesson covers. A lesson is one idea, not one chapter: group chapters that teach the same idea, and split a chapter that carries two. Every chapter belongs to a lesson. Teach Lesson 1 in that same turn without waiting for approval of the plan.

Each lesson has:

- Teaching text of about 1,000–1,400 words, with short exact quotes from the book and their chapter.
- An interactive visual where toggles or clicks show the idea changing, with a "Lesson N of M" roadmap. Give each lesson its own page, so earlier lessons stay available.
- The practice block below.

Open every lesson after the first with two questions on earlier lessons, chosen from the ideas `course.md` lists as wrong or skipped, or from the previous lesson when it lists none.

For a programming book, write the examples in React Native (TSX) from Lesson 1, even when the book uses another language: keep the book's idea and translate its example. For other books, use everyday situations instead of the book's jargon.

When the user is confused, answer their exact question first, explain with a different example instead of repeating the first one, and update that lesson's visual in place.

## Practice block

End every Explanation turn (a book lesson, or a transcript or one part of it) with these two, in this order:

- **Your move**: three concrete things to check or try in the user's own work.
- **Check yourself**: two or three questions the user answers from memory, without the answers shown. Each question asks them to use an idea from this turn on a new case, not to repeat a definition.

Answering from memory is what makes the material stick, and the answers show which part to teach again, so do not replace the questions with "did this make sense?". When the user answers, say what was right, correct what was wrong with a different example from the one in the lesson, then offer the next lesson or part. When the user asks to move on without answering, move on, and treat those questions as skipped.

## Visuals

Every mode gets visuals, because the user learns faster from a picture of an idea than from a paragraph about it.

- Start with one overview map of how the source's ideas connect. Heavy Summary gets only this map.
- Light Summary and transcript Explanation add one small sketch per section or key concept. Each sketch shows one idea, with a line or two of text beside it.
- Draw only what the source says. Where the source is vague on a detail, draw it vague or leave it out.
- Build visuals with the host's own tools (in Amp, the `creating-artifacts` skill). If the host cannot render HTML, use a compact text diagram.
