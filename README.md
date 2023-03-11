# icestick-bench

> a test bench for various icestick fpga projects and ideas

# USAGE
Each project has its own folder under `src`, they all share modules implemented in `lib`, every project needs a top level module named `tmod`

To build a project, simply use `./run.sh [MODULE NAME]`

# ABOUT
Allows for youtube to be used from a terminal with no ads, without an account account, and while maintaining subbox functionality. 

Can be embedded into other projects using the API in `degooged_tube/ytApiHacking/__init__.py`

All youtube API scraping is done internally, with the exception of getting the streaming link for videos, which is done with `yt-dlp`
