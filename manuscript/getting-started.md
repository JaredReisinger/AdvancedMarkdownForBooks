# Getting Started

> Random notes as I get the projects/repos/books started, so that I don't forget
> anything...

After \index{LeanPub}LeanPub shares the Dropbox folder with you, and you've
created a repository, you can "import" the existing LeanPub content by mapping
the Dropbox folder into the repository:

```
C:\YOU\GitHub\YourBook\> linkd source C:\YOU\Dropbox\YourBook
```

This makes `C:\YOU\GitHub\YourBook\source` an NTFS junction that points to
`C:\YOU\Dropbox\YourBook`.  Any time you (or git, via `git pull`, say) make changes
to the files in `source`, you'll actually be changing the files in the Dropbox
folder, which in turn means that LeanPub will see them.
