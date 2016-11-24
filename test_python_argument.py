import logging
import datetime
import sys
import getopt

def main(argv):
    try:
        opts, args = getopt.getopt(argv, 'hi:d:m:', ["ifile=", "date=", "metric="])
    except getopt.GetoptError:
        print 'Usage: archive_blob.py -i <inputfile> -d <date_to_inspect>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'Usage: archive_blob.py -i <inputfile> -d <date_to_inspect>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-d", "--date"):
            date = arg
        elif opt in ("-m", "--metric"):
            calc_metric = arg

    print("input file: " + inputfile)
    print("date: " + date)
    print("metric: " + calc_metric)

if __name__ == "__main__":
    main(sys.argv[1:])
