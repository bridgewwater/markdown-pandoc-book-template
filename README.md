# Markdown -> Pandoc -> Book creation

The real **Future Proof** solution

I am writing several books and i want to keep all sources as plain text files, since for too many reasons i don't want to use Word Processors or DTP to keep the sources of my writings.


## Syntax
```
# makefile helper
make help

# need mkdir dist
pandoc -d config_pdf.yaml src/*.md
pandoc -d config_epub.yaml src/*.md
pandoc -d config_docx.yaml src/*.md
pandoc -d config_html.yaml src/*.md
```

## Requirements

- Install Pandoc (version 2.11 at least): [Installing Pandoc](https://pandoc.org/installing.html).
- Install a LaTeX distribuition.
under mac i could work with the smaller [BasicTeX](https://www.tug.org/mactex/morepackages.html)

i installed both with:
```
brew install pandoc
brew install basictex
```

Update: i've moved to the much bigger but really complete [MacTeX-2020 Distribution](https://www.tug.org/mactex/)

## How To

the book is in the `src/` directory as a group of markdown files.
indeed we call Pandoc with `src/*.md` which feeds all the .md files, that's why we prefix the files with the numered order

most of the book metadata are in the `000_metadata.md` file, check there all the options.
the other settings are in the `config_.yaml`

the generated files are in the `dist/` directory.

## Thanks
- <https://brainbaking.com/post/2020/05/using-pandoc/>
- <https://blog.semanticart.com/2014/01/11/writing-hypertext-fiction-in-markdown/>
- <https://github.com/maehr/academic-pandoc-template>
- <https://github.com/adunning/pandoc-ebook>
- <https://github.com/johnpaulada/pandoc-markdown-book-template>
- <https://github.com/Carleslc/Readteractive>
- <https://github.com/StefanoCecere/markdown_pandoc_book_template>

## License

This project is loved by sinlov and .md friends and licensed under the MIT License see [LICENSE.md](LICENSE.md)
