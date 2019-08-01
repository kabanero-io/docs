# Documentation
Docs for the kabanero-io site. These docs are dynamically pulled in during the [Kabanero-website](https://github.com/kabanero-io/kabanero-website) build process.

# Contribute to the Documentation

## Create Doc
Create an a AsciiDoc file that contains the documentation in a presentable format. For help on syntax you can view this [AsciiDoc syntax reference sheet](https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/)

For AsciiDoc editors there are a few options you can use, such as, your browser, an IDE, and more. See [Editing AsciiDoc with Live Preview](https://asciidoctor.org/docs/editing-asciidoc-with-live-preview/#using-a-web-browser-preview-only)

### Add Images
To add an image to your AsciiDoc put the image in the img directory. You can reference this image in your AsciiDoc by using the path to the img directory. For example, if you added `my_image.png` to the img directory you can use that image with the following AsciiDoc syntax: `image::/docs/img/my_image.png[My image alt text]`. The image will not show for the GitHub preview, but it will be linked on the website when its deployed.

## Doc Location

In this repository you shoud place the doc under the folder that best describes the documentation category. These folders located in the [ref directory](https://github.com/kabanero-io/docs/tree/master/ref)

If no folder / category exists for your documentation feel free to create a properly named folder in the [ref directory](https://github.com/kabanero-io/docs/tree/master/ref) and place your asciidoc file in there.

If the documentation doesn't really fit in its own category you can place the doc in the [general directory](https://github.com/kabanero-io/docs/tree/master/ref/general)



