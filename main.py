import xml.etree.cElementTree as ET
import re
import sys
sys.path.append('.')
from RailML.railML import railML
from RailML.Common.Metadata import Metadata
#from RailML.Infrastructure import *
#from RailML.Interlocking import *

XMLNS = "https://www.railml.org/schemas/3.1"
XMLNS_DC ="http://purl.org/dc/elements/1.1/"
XMLNS_GML="http://www.opengis.net/gml/3.2/"
XMLNS_XSI="http://www.w3.org/2001/XMLSchema-instance"
XSI_SCHEMALOCATION="https://www.railml.org/schemas/3.1 https://www.railml.org/schemas/3.1/railml3.xsd"
VERSION = "3.1"

#%%
def print_leaves(root,leaf,tag):
    print('-'*20+ leaf +'-'*20)
    ns = re.match(r'{.*}', root.tag).group(0)
    if leaf != '':
        leaves = root.find(f"{ns}"+leaf)
    else:
        leaves = root
        
    ns_leaf = '{'+tag+'}'
    for child in leaves:
        print(f'{child.tag[len(ns_leaf):]} | {child.attrib}')    

#RailML\Example_1\src\example_1.xml
#%%

def main():
    tree = ET.parse("RailML/Example_1.railml")
    root = tree.getroot()
    

    print_leaves(root,'',XMLNS)

    print_leaves(root,'metadata',XMLNS_DC)
    print_leaves(root,'common',XMLNS)
    print_leaves(root,'infrastructure',XMLNS)
    print_leaves(root,'interlocking',XMLNS)

    RML = railML()
    
    metadata = Metadata()
    RML.setMetadata(metadata)

if __name__ == "__main__":
    main()