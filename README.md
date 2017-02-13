#watcher

A simple tool that will execute a file whenever it detects a change

##usage
```bash
$ ./watcher.sh [options] -- <file> [options]

# display help
$ ./watcher.sh --help

# change interval (default 10 seconds)
$ ./watcher.sh -i [n] -- <file>_[options]"
$ ./watcher.sh --interval=[n] -- <file> [options]"

# check for changes in base dir instead of file
$ ./watcher.sh --recursive -- <script> [options]

# always reload script regardless of changes
$ ./watcher.sh --no-hash -- <script> [options]
```

##unabashed
unabashed is a simple framework that helps with script development. It is available here <https://github.com/MetaphoricalSheep/unabashed>. The watcher repo currently includes a copy of unabashed, but this will change once update-unabashed is able to pull down the repo.
