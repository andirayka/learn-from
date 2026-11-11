# learn-from

An agent skill that turns a YouTube transcript, book, or article into study notes with simple visuals. It detects what you attached and picks the output format.

| Source | Output |
| --- | --- |
| YouTube transcript | Main idea, key points with timestamps, advice, memorable examples, plus an overview map and a sketch per concept |
| Book | A lesson plan, then one beginner-friendly lesson at a time, each with an interactive visual. React Native examples for programming books. |
| Article | **Heavy Summary** (thesis plus a few bullets) or **Light Summary** (a shorter version that keeps the author's advice and intent). Asks which if you don't say. Both come with visuals. |

Every type gets visuals: an overview map of how the ideas connect, and a small sketch per key concept. Books use interactive labs; transcripts and articles use simple static diagrams.

## Install

```sh
npx skills add andirayka/learn-from
```

## Use

Attach a source and say what you want, for example "learn from this" or "heavy summary of this article".
