# Bookmarks

## What is this?
Bookmarks is a very simple iOS App to store bookmarks. When starting the application it checks your pasteboard and automatically adds a found url.

## In what state is this project?
This project was developed in a day and there are many things to do!

## Todos:
### Specific small things:
* cleanup *doh*
* animate adding, removing, updating bookmarks
* parse the favicon url when adding the bookmark, not when displaying it
* precaching the favicon?
* optimize favicon downloading code
* optimize asynchronous image downloading code
* add content/help screen
* optimize the observing on the BookmarkStorage
* follow HTTP redirects before determining which url to add
* add a logic to regulary scan through all bookmarks and update them (do we really want that, or do we want to keep the originals?)
* Add an Icon
* Add some color

### General ideas:
* Add search! This is the main idea of this tool. To search the content of the website.
* Add a share Extension
* Screenshots. Render the websites and use them to display the bookmarks.
* Categorizing Bookmarks.
* Sync
* Optimize the Browser:
** navigate backwards and forwards
** add the current page to the bookmarks
** Add a open-in-safari button