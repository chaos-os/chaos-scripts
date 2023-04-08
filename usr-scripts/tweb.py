#!/usr/bin/env python
# -*- coding:utf-8 -*-

"""A program which is a collection of all useful curl based internet programs for daily use"""


# -------------------------Command Line Arguments------------------------
from argparse import ArgumentParser
from typing import Dict, Tuple
from pycurl import (
    ACCEPT_ENCODING,
    CAINFO,
    CONNECTTIMEOUT,
    FOLLOWLOCATION,
    MAXCONNECTS,
    MAXREDIRS,
    NOPROGRESS,
    NOSIGNAL,
    TIMEOUT,
    URL,
    USERAGENT,
    WRITEDATA,
    Curl,
)
from io import BytesIO
from certifi import where
from bs4 import BeautifulSoup
from json import dumps, loads

# -------------------------Constants------------------------
CHARSET: str = "utf-8"

SPOOFING_USER_AGENT: str = (
    "Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101 Firefox/102.0"
)
NORMAL_USER_AGENT: str = "curl/7.88.1"
REJECT_ENCODING: None = None
FOLLOW_LOCATION: int = 1
MAX_REDIRECTS: int = 5
CONNECTION_REQUEST_TIMEOUT: int = 30
TRANSFER_TIMEOUT: int = 300
RAISE_NO_SIGNAL_ON_FAILURES: int = 1
HIDE_PROGRESS: bool = True
CONN_POOL_SIZE_FOR_MULTIPLE_SIMULTANEOUS_CONNS: int = 5

LINES_TO_INCLUDE_WITH_STRING: str = "Port test"

REPLACEMENT_STRINGS: Tuple = ("qrenco.delibqrencode", "qrenco.de")
EMPTY_STRING: str = ""

PARSER: str = "lxml"

WEATHER_URL: str = "wttr.in/"
WEATHER_URL_FORMAT: str = "?format=+%c<-%C+%t"
QR_CODE_GEN_WEBSITE_URL: str = "qrenco.de/"
NEWS_FETCHING_URL: str = "us.getnews.tech/"
PORT_TESTING_URL: str = "portquiz.net:"
IP_FETCHER_URLS: Tuple = ("ifconfig.co/json", "ifconfig.es/json")
DICT_URL: str = "dict.org/d:"
CHEATSHEET_URL: str = "https://cht.sh/"

WHITESPACE_CHAR: str = " "
PLUS_SIGN_CHAR: str = "+"

JSON_INDENT: int = 4
JSON_SORT_KEYS: bool = True


# -------------------------Functions------------------------
def process_request(url: str, user_agent: str = SPOOFING_USER_AGENT) -> str:
    """A function that takes in an url as parameter with the default user agent
    if user_agent parameter is provided and fetching data from the website returning it
    """

    buffer = BytesIO()
    curl: Curl = Curl()
    curl.setopt(URL, url)
    curl.setopt(USERAGENT, user_agent)
    curl.setopt(CAINFO, where())
    curl.setopt(ACCEPT_ENCODING, REJECT_ENCODING)
    curl.setopt(FOLLOWLOCATION, FOLLOW_LOCATION)
    curl.setopt(MAXREDIRS, MAX_REDIRECTS)
    curl.setopt(CONNECTTIMEOUT, CONNECTION_REQUEST_TIMEOUT)
    curl.setopt(TIMEOUT, TRANSFER_TIMEOUT)
    curl.setopt(NOSIGNAL, RAISE_NO_SIGNAL_ON_FAILURES)
    curl.setopt(WRITEDATA, buffer)
    curl.setopt(NOPROGRESS, HIDE_PROGRESS)
    curl.setopt(MAXCONNECTS, CONN_POOL_SIZE_FOR_MULTIPLE_SIMULTANEOUS_CONNS)

    curl.perform()
    curl.close()

    body = buffer.getvalue()
    return body.decode(CHARSET)


def get_weather(place: str) -> None:
    """Fetches the weather from the website by providing the arguments and displaying the result"""

    print(
        f"{place.title()}:",
        process_request(
            f"{WEATHER_URL}{place.title().replace(WHITESPACE_CHAR,PLUS_SIGN_CHAR)}{WEATHER_URL_FORMAT}"
        ),
    )


def get_qr_code(url: str) -> None:
    """Fetches the qr code generated from the website by providing the url argument,
    then scraping out the useful from the respone and  displaying the result"""

    response: str = process_request(f"{QR_CODE_GEN_WEBSITE_URL}{url}")
    soup: BeautifulSoup = BeautifulSoup(response, PARSER)
    for line in soup.text.splitlines():
        if line.endswith(REPLACEMENT_STRINGS[0]):
            print(line.replace(REPLACEMENT_STRINGS[0], EMPTY_STRING))
        elif line.startswith(REPLACEMENT_STRINGS[1]):
            print(line.replace(REPLACEMENT_STRINGS[1], EMPTY_STRING))
        else:
            print(line)


def get_cheatsheet(keywords: str) -> None:
    """Fetches the cheatsheet from the website by providing the program name as an argument,
    then scraping out the useful from the respone and displaying the result"""

    response: str = process_request(
        f"{CHEATSHEET_URL}{keywords.replace(WHITESPACE_CHAR,PLUS_SIGN_CHAR)}"
    )
    soup: BeautifulSoup = BeautifulSoup(response, PARSER)
    for line in soup.text.splitlines():
        if line.strip():
            print(line)


def get_defination(keywords: str) -> None:
    """Fetches the defination of the word provided as an argument and displaying the result"""

    print(
        process_request(f"{DICT_URL}{keywords.replace(WHITESPACE_CHAR,PLUS_SIGN_CHAR)}")
    )


def get_my_ip() -> None:
    """Fetches the ip of the current network"""

    data_from_first_url: Dict = loads(process_request(IP_FETCHER_URLS[0]))
    data_from_second_url: Dict = loads(process_request(IP_FETCHER_URLS[1]))

    combined_data: Dict = {**data_from_second_url, **data_from_first_url}

    print(dumps(combined_data, indent=JSON_INDENT, sort_keys=JSON_SORT_KEYS))


def get_result_from_port_test(port: int) -> None:
    """Fetches the result of the port test of whether the port provided is accessible from
    outside the network by providing port number as an argument and displaying the result
    """

    response: str = process_request(f"{PORT_TESTING_URL}{port}")
    soup: BeautifulSoup = BeautifulSoup(response, PARSER)
    for line in soup.text.splitlines():
        if line.startswith(LINES_TO_INCLUDE_WITH_STRING):
            print(line)
            break


def get_news(keywords: str) -> None:
    """Fetches the latest news headlines according to the parameters provided as an argument
    and displaying the result"""

    print(
        process_request(
            f"{NEWS_FETCHING_URL}{keywords.replace(WHITESPACE_CHAR,PLUS_SIGN_CHAR)}",
            NORMAL_USER_AGENT,
        )
    )


def get_dns_info() -> None:
    """Fetches the dns information of the current network"""

    print(process_request("https://edns.ip-api.com/json"))


def get_shortened_url(url: str) -> None:
    """Provides a shortened url based on the given parameter of the original url"""
    print(process_request(f"tinyurl.com/api-create.php?url={url}"))


def get_info_on_common_websites() -> None:
    """Fetches the status of commonly accessed websites"""
    print(process_request("https://status.plaintext.sh/t"))


def get_corona_stats_worldwide() -> None:
    """Fetches the corona stats of all the nations worldwide"""
    print(process_request("https://corona-stats.online"))


def get_corona_stats_of_current_country() -> None:
    """Fetches the corona stats of the current country you are in"""
    print(
        process_request("snf-878293.vm.okeanos.grnet.gr", user_agent=NORMAL_USER_AGENT)
    )


def get_random_jokes() -> None:
    """Provides random jokes"""
    print(process_request("https://icanhazdadjoke.com", user_agent=NORMAL_USER_AGENT))


def get_hacker_news_feed() -> None:
    """Fetches the hacker news(HN) news feed"""
    print(process_request("hkkr.in", user_agent=NORMAL_USER_AGENT))


# -------------------------Command Line Arguments------------------------
parser = ArgumentParser(
    description="A program which is a collection of all useful curl based internet programs for daily use"
)
parser.add_argument(
    "-w",
    "--weather",
    help="show weather according to the region name provided",
    type=str,
)
parser.add_argument(
    "-q",
    "--qr-code",
    help="generate qr code based on the provided url or words",
    type=str,
)
parser.add_argument(
    "-c", "--cheat", help="fetch a cheatsheet for the given program", type=str
)
parser.add_argument("--ip", help="give the ip of the network", action="store_true")
parser.add_argument(
    "-p",
    "--port-test",
    help="give the result of a port test of whether the provided port was accessible from outside the network",
    type=int,
)
parser.add_argument(
    "--dns", help="give the dns information of the network", action="store_true"
)
parser.add_argument(
    "-d", "--define", help="provide the defination of the given word", type=str
)
parser.add_argument(
    "-n",
    "--news",
    help="fetch all latest news headlines according to the provided parameters",
    type=str,
)

parser.add_argument(
    "-s", "--shorten", help="provide the defination of the given word", type=str
)
parser.add_argument(
    "--commons", help="give the information of all common websites", action="store_true"
)
parser.add_argument(
    "--cww",
    help="give the stats on corona of all countries world wide",
    action="store_true",
)
parser.add_argument(
    "--ccc",
    help="give the stats on corona of current country",
    action="store_true",
)
parser.add_argument(
    "-j", "--jokes", help="generate some random jokes", action="store_true"
)
parser.add_argument(
    "--hacker-news",
    help="give me all the headlines of latest news feed from hacker news(HN)",
    action="store_true",
)
args = parser.parse_args()

if args.weather:
    get_weather(args.weather.strip())
if args.qr_code:
    get_qr_code(args.qr_code.strip())
if args.cheat:
    get_cheatsheet(args.cheat.strip())
if args.define:
    get_defination(args.define.strip())
if args.ip:
    get_my_ip()
if args.port_test:
    get_result_from_port_test(args.port_test)
if args.news:
    get_news(args.news.strip())
if args.dns:
    get_dns_info()
if args.shorten:
    get_shortened_url(args.shorten.strip())
if args.commons:
    get_info_on_common_websites()
if args.cww:
    get_corona_stats_worldwide()
if args.ccc:
    get_corona_stats_of_current_country()
if args.jokes:
    get_random_jokes()
if args.hacker_news:
    get_hacker_news_feed()
