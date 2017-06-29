#!/usr/bin/python2
# -!- coding: utf-8 -!-

import argparse
import logging
import sys
import rdflib

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input', help='RDF file that should be used as an input or - for STDIN')
    parser.add_argument('output', help='RDF file that should be used as an output or - for STDIN')
    # TODO: read a parser list from rdflib
    parser.add_argument('-i', '--input-format', help='Input format. Turtle by default', choices=('turtle', 'xml'), default='turtle')
    parser.add_argument('-o', '--output-format', help='Output format. RDF/XML by default', choices=('turtle', 'xml'), default='xml')

    args = parser.parse_args()

    logging.basicConfig(format='%(levelname)s: %(message)s', level=logging.INFO)

    g = rdflib.Graph()
    g.parse(args.input, format=args.input_format)
    g.serialize(args.output, format=args.output_format)
