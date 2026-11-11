# learn-from

An agent skill that turns a YouTube transcript, book, or article into study notes with simple visuals. It detects what you attached and picks the output format.

| Source | Modes |
| --- | --- |
| YouTube transcript | **Explanation** (key concepts in plain words, advice, a sketch per concept) or **Summary** (Heavy or Light) |
| Book | **Explanation** (a lesson plan, then one beginner-friendly lesson at a time with an interactive visual; React Native examples for programming books) or **Summary** (Heavy or Light) |
| Article | **Heavy Summary** (thesis plus a few bullets) or **Light Summary** (a shorter version that keeps the author's advice and intent) |

Transcripts and books are explained in full unless you ask for a summary. Articles get a Light Summary unless you ask for a heavy one.

Every type gets visuals: an overview map of how the ideas connect, and a small sketch per key concept. Book lessons use interactive visuals.

## Install

```sh
npx skills add andirayka/learn-from
```

## Use

Attach a source and say what you want, for example "learn from this" or "heavy summary of this article".
