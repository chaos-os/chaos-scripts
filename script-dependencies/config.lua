config = {
    bat_notify_timer = 60, -- seconds
    threshold = 20, -- number
    search_engines = {
        YouTube = { Link = "https://www.youtube.com/results?search_query=", Seperator = "+", args = "" },
        Reddit = { Link = "https://libreddit.spike.codes/r/", Seperator = "", args = "" },
        Twitter = { Link = "https://nitter.net/search?f=users&q=", Seperator = "+", args = "" },
        Odysee = { Link = "https://odysee.com/$/search?q=", Seperator = "+", args = "" },
        ArchWiki = { Link = "https://wiki.archlinux.org/title/", Seperator = "_", args = "" },
        SearXNG = { Link = "https://search.disroot.org/?q=", Seperator = "+", args = "" },
        Piped = { Link = "https://piped.kavin.rocks/results?search_query=", Seperator = "+", args = "" },
        MdnDocs = { Link = "https://developer.mozilla.org/en-US/search?q=", Seperator = "+", args = "&sort=relevance" },
        DocsRust = { Link = "https://docs.rs/xcb/1.2.0/xcb/?search=", Seperator = "+", args = "" },
        PyDocs = { Link = "https://docs.python.org/3/search.html?q=", Seperator = "+", args = "" },
        SvgImages = { Link = "https://www.svgrepo.com/vectors/", Seperator = "-", args = "" },
    },
    bookmarks = {
        "https://www.youtube.com/results?search_query=distrotube",
        "https://search.disroot.org/?q=arch+wiki",
    },
}

return config
