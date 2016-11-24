#!/usr/bin/python

## @deprecated

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
import logging
import datetime
import sys
import getopt

__author__ = "tony"
__date__ = "$Nov 22, 2016 11:06:38 PM$"

__module__ = "archive_blob"
#logfile = "/home/tony/bimax_docker/pw1/gits/Bimax_test/src/log/" + __module__ + ".log"
#input = __module__ + ".txt"

#parameters to check archive performance
typical_archive = 300  #typical archive take 5 min to finish
config_myperiod = 600

#logging.basicConfig(logfile,level=logging.DEBUG)

def init_count_list(args):
    count_list = {}
    #start = datetime.datetime(2016, 11, 22, 0, 0, 0)
    #end = datetime.datetime(2016, 11, 22, 23, 50, 0)
    
    start = datetime.datetime.strptime(args + ' 00:00:00', "%Y_%m_%d %H:%M:%S")
    end = datetime.datetime.strptime(args + ' 23:50:00', "%Y_%m_%d %H:%M:%S")
    
    while (start <= end ):
        #print str(start)
        count_list[ str(start) ] = 0
        start = start + datetime.timedelta(seconds=config_myperiod)
    return count_list

def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hi:d:",["ifile=","date="])
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
    input = inputfile + '.txt'
    output = inputfile + '.o'
        
    count_list = init_count_list(date)
    slow_archives = dict()
    wrong_archives = dict()
    f = open(input, 'r')
    fwrite = open(output, 'w')
    
    for line in f:
        try:
            #logging.info(message)
            result = line.split(',')
            
            #trim the trailing line break
            result[3] = result[3][:-1]
            #print ('  '.join(result))
            if result[1] in count_list:
                count_list[result[1]] += 1
                
                date2 = datetime.datetime.strptime(result[2], "%Y-%m-%d %H:%M:%S")                
                date2s = date2 + datetime.timedelta(seconds=1)
                date2e = date2 + datetime.timedelta(seconds=typical_archive)
                ts_archive = datetime.datetime.strptime(result[3], "%Y-%m-%d %H:%M:%S")
                #ts_archive is in UTC
                ts_archive = ts_archive + datetime.timedelta(seconds=7*3600)
                if ts_archive < date2s:
                    wrong_archives[result[1]] = str(ts_archive)
                if ts_archive > date2e:
                    slow_archives[result[1]] = str(ts_archive)
            else:
                print ('!!!Error day is not in list: ' + result[1])
        except Exception, err:
            logging.info(err)
            continue

    fwrite.write ("=== Report === \n")
    fwrite.write ("*** Archive performance *** \n")
    fwrite.write ("Slow archives \n")
    fwrite.write ("------------------------------- \n")
    for key in sorted(slow_archives.iterkeys()):
        fwrite.write ("{0:s} -> {1:s} \n".format(key, slow_archives[key]))
    
    fwrite.write ('\n')
    fwrite.write ("Unexpected archives \n")
    fwrite.write (" ------------------------------- \n")
    for key in sorted(wrong_archives.iterkeys()):
        fwrite.write ("{0:s} -> {1:s} \n".format(key, wrong_archives[key]))    
    
    fwrite.write ('\n \n')
    fwrite.write ("   *** Archive count with date1 *** \n")
    
#    for key in sorted(count_list.iterkeys()):
#        print ("{0:s} -> {1:d}".format(key, count_list[key]))
    
    # The below kind of traversing a dictionary caused errors 
    # when poping keys from count_list while key continue looping
    # on those values
    #for key in sorted(count_list.iterkeys()):
    
#    for key in keys:
#        pivot = count_list[key]
#        print ("calculated: {0:d}".format(pivot))
#        print ("--------------------------")
#        print (key)
#        count_list.pop(key)
#        keys.remove(key)
#        for key1 in keys:
#            if count_list[key1] == pivot:
#                print(key1)
#                count_list.pop(key1)
#                keys.remove(key1)

    keys = sorted(count_list.iterkeys())
    processed_map = dict()
    for key in keys:
        if count_list[key] in processed_map:
            processed_map[count_list[key]].append(key)
        else:
            processed_map[count_list[key]] = [key]
            
    for key in processed_map:
         
        fwrite.write ("calculated: {0:d} \n".format(key))
        fwrite.write ("-------------------------- \n")
        i = 1
        for atime in processed_map[key]:
            #fwrite.write (processed_map[key] + ', ')
            fwrite.write (atime + ', ')
            if i % 4 == 3:
                fwrite.write('\n')
            i += 1
        fwrite.write ('\n')
        
        
        
if __name__ == "__main__":
    main(sys.argv[1:])
