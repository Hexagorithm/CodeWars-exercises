#!/usr/bin/python3
import sys  # for sys.argv

def whatday(num):
    num2day = {
            1:"Sunday",
            2:"Monday",
            3:"Tuesday",
            4:"Wednesday",
            5:"Thursday",
            6:"Friday",
            7:"Saturday",
            }
    try:
        num = int(num)
        if num not in list(num2day):
            return "Wrong, please enter a number between 1 and 7"
        return num2day[num]
    except ValueError:
        return "Wrong, please enter a number between 1 and 7"


if __name__ == "__main__":
    args = sys.argv[1:]
    ret = whatday(*args)
    print(f"For arguments: \"{args}\" the return is \"{ret}\".")
