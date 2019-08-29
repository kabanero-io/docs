# Kabanero.io Documentation
This repository holds the documentation for the kabanero-io site. These docs are dynamically pulled in during the [Kabanero-website](https://github.com/kabanero-io/kabanero-website) build process.

# How to contribute to the documentation

## Doc format

You have 2 options when creating docs: Markdown and AsciiDoc.
   * We use Jekyll, which uses the [kramdown](https://jekyllrb.com/docs/configuration/markdown/#kramdown) Markdown renderer, which still supports standard Markdown with some minor modifications.
   * We use the [Jekyll-asciidoc](https://github.com/asciidoctor/jekyll-asciidoc) plugin, which uses [Asciidoctor](https://asciidoctor.org/) to render [AsciiDocs](http://asciidoc.org/)

## Doc Front Matter
You need the proper front matter on each doc to get it categorized correctly. The `title` and the `doc-category` are the only one you should change for your doc.
  * For Markdown, use a YAML front matter
    ```
    ---
    layout: general-reference
    type: doc
    title: Kabanero Introduction
    doc-category: Getting Started
    ---
    ```
  * For AsciiDoc, use `page-` AsciiDoc attributes in place.
    ```
    :page-layout: general-reference
    :page-type: doc
    :page-title: Kabanero Intro
    :page-doc-category: Getting Started
    :linkattrs:
    ```

## Doc Syntax

Create an a Markdown/AsciiDoc file that contains the documentation in a presentable format. For help on syntax you can view these references.
  * Syntax references
    * [kramdown syntax](https://kramdown.gettalong.org/syntax.html)
    * [AsciiDoc syntax](https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/)
  * Editor options
    * See [kramdown live editor](http://trykramdown.herokuapp.com/)
    * See [AsciiDoc editor options](https://asciidoctor.org/docs/editing-asciidoc-with-live-preview/#using-a-web-browser-preview-only)

## Do Not Publish Doc Yet

If you want to get a doc ready ahead of time, but do not want it published to the site you can still contribute the doc, but be sure to include the `published: false` front matter. When you are ready to the doc to be published you can remove the `published` front matter variable.
  * For Markdown use `published: false`
  * For AsciiDoc use `:page-published: false`

## Add Images

To add an image to your AsciiDoc put the image in the img directory. You can reference this image in your AsciiDoc by using the path to the img directory. For example, if you added `my_image.png` to the img directory you can use that image with the following AsciiDoc syntax: `image::/docs/img/my_image.png[My image alt text]`. The image will not show for the GitHub preview, but it will be linked on the website when its deployed.

## Doc Location

In this repository you shoud place the doc under the folder that best describes the documentation category. These folders located in the [ref directory](https://github.com/kabanero-io/docs/tree/master/ref)

If no folder / category exists for your documentation feel free to create a properly named folder in the [ref directory](https://github.com/kabanero-io/docs/tree/master/ref) and place your asciidoc file in there.

If the documentation doesn't really fit in its own category you can place the doc in the [general directory](https://github.com/kabanero-io/docs/tree/master/ref/general)



