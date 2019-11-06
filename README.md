# Kabanero.io Documentation
This repository holds the documentation for the kabanero-io site **Docs** area. These docs are dynamically pulled in during the [Kabanero-website](https://github.com/kabanero-io/kabanero-website) build process.

# How to contribute to the documentation

## Before You Start
  * Click the `fork` button to create your fork of the `docs` repo. Make changes on your fork then open a pull request against `kabanero-io/docs:master` when you're ready for the changes to be reviewed and merged.

## Doc format

You have 2 options when creating docs: Markdown and AsciiDoc.
   * We use Jekyll, which uses the [kramdown](https://jekyllrb.com/docs/configuration/markdown/#kramdown) Markdown renderer, which still supports standard Markdown with some minor modifications.
   * We use the [Jekyll-asciidoc](https://github.com/asciidoctor/jekyll-asciidoc) plugin, which uses [Asciidoctor](https://asciidoctor.org/) to render [AsciiDocs](http://asciidoc.org/)

## Doc Front Matter
You need the proper front matter on each Docs page to get it categorized correctly. The `title` and the `doc-category` are the only one you should change.
  * For Markdown, use a YAML front matter
    ```
    ---
    layout: general-reference
    doc-category: Configuration
    title: Connecting Kabanero to GitHub with Tekton Webhooks
    ---
    ```
  * For AsciiDoc, use `page-` AsciiDoc attributes in place.
    ```
    :page-layout: general-reference
    :page-doc-category: Configuration
    :page-title: Connecting Kabanero to GitHub with Tekton Webhooks
    :linkattrs:
    :sectanchors:
    ```

## Doc Categories

We currently have 3 categories you can use for the `doc-category` or `page-doc-category` front matter:

* Installation
* Reference
* Configuration

If you need a new category feel free to open an issue or discussion in a pull request about the new category.

## Doc category order in table of contents

The [doc-categories.adoc](https://github.com/kabanero-io/docs/blob/master/doc-categories.adoc) file configures the order that the doc categories will show up on our table of contents for the website. Currently the order is:

   1. Installation
   1. Configuration
   1. Reference

This file should only be updated if a *new* category is added.
   * If a new category is added you must place your category in the `page-categories` in the order you want it to show up on the site.

## Doc Syntax

Create a Markdown/AsciiDoc file that contains the documentation in a presentable format. For help on syntax you can view these references:

  * Syntax references
    * [kramdown syntax](https://kramdown.gettalong.org/syntax.html)
    * [AsciiDoc syntax](https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/)
  * Editor options
    * See [kramdown live editor](http://trykramdown.herokuapp.com/)
    * See [AsciiDoc editor options](https://asciidoctor.org/docs/editing-asciidoc-with-live-preview/#using-a-web-browser-preview-only)

## Do Not Publish Doc Yet

If you want to get a Docs page ready ahead of time, but do not want it published to the site you can still contribute the file, but be sure to include the `published: false` front matter. When you are ready for the Docs page to be published, you can remove the `published` front matter variable:

  * For Markdown use `published: false`
  * For AsciiDoc use `:page-published: false`

## Add Images

To add an image to your Docs page, put the image in the `img/` directory. You can reference this image in your Docs page by using the path to the `img/` directory. For example, if you added `my_image.png` to the `img/` directory you can use that image with the following syntax:

- AsciiDoc format: `image::/docs/img/my_image.png[My image alt text]`.
- Markdown format: `![My image alt text](/docs/img/my_image.png)`

Note: The image will not show for the GitHub preview, but it will be linked on the website when it's deployed.

## Doc Location

In this repository you should place your new Docs page under the folder that best describes the documentation category. These folders are located in the [ref directory](https://github.com/kabanero-io/docs/tree/master/ref)

## Render Docs locally

When you have your local development environment setup you can render Docs pages as your write them.

### Prereqs

- [Local development setup](https://github.com/kabanero-io/kabanero-website/blob/master/CONTRIBUTING.md#local-development-setup)

### Render your guide

1. Create a new `docs/` subdirectory under `src/main/content/` in your github.com/kanabero.io/kabanero-website.git repository.
2. Copy all directories and content from your local github.com/kabanero-io/docs.git repository underneath this subdirectory.
3. Create your new Docs file in an appropriate directory (See Doc Location).
4. Copy any images that you are using in your guide to the `src/main/content/docs/img/` directory (This is done automatically during website build, but is needed during local development).
5. Start your local dev server and go to https://localhost:4000/docs to see all the Docs pages rendered.
