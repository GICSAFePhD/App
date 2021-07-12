import xml.etree.cElementTree as ET
from xml.dom import minidom
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
        print(f'{child.tag[len(ns_leaf):]} | {child.attrib} | {child.text}')

def metadata_set(root,leaf,tag,object):
    ns = re.match(r'{.*}', root.tag).group(0)
    if leaf != '':
        leaves = root.find(f"{ns}"+leaf)
    else:
        leaves = root
        
    ns_leaf = '{'+tag+'}'
    
    object.Title = leaves[0].text
    object.Date = leaves[1].text
    object.Creator = leaves[2].text
    object.Source = leaves[3].text
    object.Identifier = leaves[4].text
    object.Subject = leaves[5].text
    object.Format = leaves[6].text
    object.Description = leaves[7].text
    object.Publisher = leaves[8].text

def metadata_to_XML(root_ML,metadata):
    #ET.SubElement(root_ML, "field3", name="blah").text = "some value1"
    
    ET.SubElement(root_ML, "title").text = metadata.Title
    
    
    #object.Title = leaves[0].text
    #object.Date = leaves[1].text
    #object.Creator = leaves[2].text
    #object.Source = leaves[3].text
    #object.Identifier = leaves[4].text
    #object.Subject = leaves[5].text
    #object.Format = leaves[6].text
    #object.Description = leaves[7].text
    #object.Publisher = leaves[8].text   


#RailML\Example_1\src\example_1.xml
#%%
def main():
    tree = ET.parse("RailML/Example_1.railml")
    root = tree.getroot()
    
    #print_leaves(root,'',XMLNS)
    #print_leaves(root,'metadata',XMLNS_DC)
    #print_leaves(root,'common',XMLNS)
    #print_leaves(root,'infrastructure',XMLNS)
    #print_leaves(root,'interlocking',XMLNS)

    RML = railML()
    
    metadata = Metadata()

    metadata_set(root,'metadata',XMLNS_DC,metadata)
    
    RML.Metadata = metadata
    
    #print(RML.Metadata)

    root_ML = ET.Element("railML", xmlns=XMLNS)
    metadata_ML = ET.SubElement(root_ML, "metadata")

    metadata_to_XML(metadata_ML,metadata)
    


    #tree2 = ET.ElementTree(root2)
    #tree2.write("filename.xml")
    
    xmlstr = minidom.parseString(ET.tostring(root_ML)).toprettyxml(indent="   ")
    with open("RailML/Example_2.railml", "w") as f:
        f.write(xmlstr)
    
if __name__ == "__main__":
    main()