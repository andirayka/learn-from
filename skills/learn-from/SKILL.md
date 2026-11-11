---
name: learn-from
description: Turns a YouTube transcript, book, or article into study material with visuals, as a full explanation or as a heavy or light summary. Use when the user attaches or links a transcript, book, or article and asks to learn from it, explain it, or summarize it.
---

# Learn From

Turn the source into material the user can learn from, with visuals that show the ideas. The learner is a React Native developer who wants knowledge they can apply. Write for a beginner: plain words, and no jargon before it is explained.

## Modes

- **Explanation** (transcripts and books): teach the source in full, so the user ends up with its applicable knowledge as if they had consumed all of it.
- **Heavy Summary**: only what the reader must know. A one-sentence thesis, then a few one-sentence bullets. For an article or transcript, stay under 10% of the original length. Cut examples, background, and caveats unless the conclusion depends on them.
- **Light Summary**: a shorter version that keeps the author's content. Follow the original order, and merge neighbouring sections, chapters, or topics that cover the same idea. Keep every piece of advice, step, number, and caveat, the examples that carry the argument, and the author's tone. For an article or transcript, aim for 25–35% of the original length; for a book, a few paragraphs per section. Write prose or the author's own list formats, not a bullet digest.

The user's words decide the mode. When they name none, a transcript or book gets Explanation and an article gets Light Summary. When they ask for a summary of a transcript or book without saying heavy or light, ask with `ask_user_choice`.

If you cannot tell whether the source is a transcript, a book, or an article, ask in one line. For a YouTube link with no transcript attached, fetch the captions; if that fails, ask for the transcript.

## Explaining a transcript

Teach the key concepts in the order a beginner should learn them, which need not be the video's order. For each concept, give what it means in plain words, why the speaker says it matters, and the speaker's example, with the timestamp when the transcript has one. Then list the advice and actions the speaker recommends.

Leave out sponsor reads, greetings, filler, and repeated points. Fix obvious auto-caption mistakes silently, and mark a passage too garbled to trust as `[unclear]`. Teach a very long transcript one part per turn.

## Explaining a book

Teach the book as lessons, one per turn.

In the first turn, read the whole book, then show a plan of 4–8 lessons with one line each. A lesson is one idea, not one chapter: group chapters that teach the same idea, and split a chapter that carries two. Teach Lesson 1 in that same turn without waiting for approval of the plan.

Each lesson has:

- Teaching text of about 1,000–1,400 words, with short exact quotes from the book and their chapter.
- An interactive visual where toggles or clicks show the idea changing, with a "Lesson N of M" roadmap. Give each lesson its own page, so earlier lessons stay available.
- "Your move": three concrete things to check in the user's own work.
- A closing question asking whether the lesson landed, offering the next lesson or a slower pass on one part.

For a programming book, write the examples in React Native (TSX) from Lesson 1, even when the book uses another language: keep the book's idea and translate its example. For other books, use everyday situations instead of the book's jargon.

When the user is confused, answer their exact question first, explain with a different example instead of repeating the first one, and update that lesson's visual in place.

## Visuals

Every mode gets visuals, because the user learns faster from a picture of an idea than from a paragraph about it.

- Start with one overview map of how the source's ideas connect. Heavy Summary gets only this map.
- Light Summary and transcript Explanation add one small sketch per section or key concept. Each sketch shows one idea, with a line or two of text beside it.
- Draw only what the source says. Where the source is vague on a detail, draw it vague or leave it out.
- Build visuals with the host's own tools (in Amp, the `creating-artifacts` skill). If the host cannot render HTML, use a compact text diagram.
