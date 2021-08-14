
import sys
sys.path.append('.')
import xml.etree.cElementTree as ET
from xml.dom import minidom
import re
from RailML.railML import railML
from RailML.Common import Metadata
from RailML.Common import Common
#from RailML.Infrastructure import Infrastructure
#from RailML.Interlocking import Interlocking
from RailML import aRailML

XMLNS = "https://www.railml.org/schemas/3.1"
XMLNS_DC ="http://purl.org/dc/elements/1.1/"
XMLNS_GML="http://www.opengis.net/gml/3.2/"
XMLNS_XSI="http://www.w3.org/2001/XMLSchema-instance"
XSI_SCHEMALOCATION="https://www.railml.org/schemas/3.1 https://www.railml.org/schemas/3.1/railml3.xsd"
VERSION = "3.1"

ATTRIBUTES = {"xmlns":XMLNS , "xmlns:dc":XMLNS_DC , "xmlns:gml":XMLNS_GML , "xmlns:xsi":XMLNS_XSI , "xsi:schemaLocation":XSI_SCHEMALOCATION , "version":VERSION}

RML = railML()

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

def get_leaves(root,leaf,tag):
    ns = re.match(r'{.*}', root.tag).group(0)
    if leaf != '':
        leaves = root.find(f"{ns}"+leaf)
    else:
        leaves = root
        
    ns_leaf = '{'+tag+'}'
    
    return [leaves,ns_leaf]

def get_leaves2(root):
    leaves = []
    leaf = []
    #ns_leaf = '{'+tag+'}'
    
    for i in root:  # HERE I CAN DO IT GENERIC
        ns = re.match(r'{.*}', i.tag).group(0)
        leaves.append(i.tag[len(ns):])
        leaf.append(i)
    
    return [leaf,leaves]

def metadata_set(root,leaf,tag,object):
    [leaves,ns_leaf] = get_leaves(root,leaf,tag)  
    
    object.Title = leaves[0].text
    object.Date = leaves[1].text
    object.Creator = leaves[2].text
    object.Source = leaves[3].text
    object.Identifier = leaves[4].text
    object.Subject = leaves[5].text
    object.Format = leaves[6].text
    object.Description = leaves[7].text
    object.Publisher = "GICSAFe"    #leaves[8].text

def common_set(root,leaf,tag,object):        
    [leaves,ns_leaf] = get_leaves(root,leaf,tag)    
        
    for child in leaves:
        #print(f'{child.tag[len(ns_leaf):]} | {child.attrib} | {child.text}')
        if child.tag[len(ns_leaf):] == "electrificationSystems":
            print(f'>>{child.tag[len(ns_leaf):]}')
            object.createElectrificationSystems
        if child.tag[len(ns_leaf):] == "organizationalUnits":
            print(f'>>{child.tag[len(ns_leaf):]}')
            object.createOrganizationalUnits()
            [organization,organization_leaf] = get_leaves(child,"infrastructureManager",XMLNS) 
            if organization != None: 
                print(f'>>>{organization.tag[len(organization_leaf):]}')
                object.OrganizationalUnits.createInfrastructureManager()
        if child.tag[len(ns_leaf):] == "speedProfiles":
            print(f'>>{child.tag[len(ns_leaf):]}')
            object.createSpeedProfiles()
        if child.tag[len(ns_leaf):] == "positioning":
            print(f'>>{child.tag[len(ns_leaf):]}')
            object.createPositioningSystems()
            
            [sub_child,tag] = get_leaves2(child,XMLNS)

            for i in range(len(tag)):
                print(f'>>>{tag[i]}')
                #print(sub_child[i])
                [a,sub_tag] = get_leaves2(sub_child[i],XMLNS) 
        
                for j in range(len(sub_tag)):
                    print(f'>>>>{sub_tag[j]}')
                    
            #if positioning != None: 
            #    print(f'>>>{positioning.tag[len(positioning_leaf):]}')
                #object.PosytioningSystems.createInfrastructureManager()
            
    #object.Title = leaves[0].text

def metadata_to_XML(root_ML,metadata):
    #ET.SubElement(root_ML, "field3", name="blah").text = "some value1"
    
    ET.SubElement(root_ML, "dc:title").text = metadata.Title
    ET.SubElement(root_ML, "dc:date").text = metadata.Date
    ET.SubElement(root_ML, "dc:creator").text = metadata.Creator
    ET.SubElement(root_ML, "dc:source").text = metadata.Source
    ET.SubElement(root_ML, "dc:identifier").text = metadata.Identifier
    ET.SubElement(root_ML, "dc:subject").text = metadata.Subject
    ET.SubElement(root_ML, "dc:format").text = metadata.Format
    ET.SubElement(root_ML, "dc:description").text = metadata.Description
    ET.SubElement(root_ML, "dc:publisher").text = metadata.Publisher
#%%
def load_xml(file):
    tree = ET.parse(file)
    root = tree.getroot()
    
    #print_leaves(root,'',XMLNS)
    #print_leaves(root,'metadata',XMLNS_DC)
    #print_leaves(root,'common',XMLNS)
    #print_leaves(root,'infrastructure',XMLNS)
    #print_leaves(root,'interlocking',XMLNS)
    return root
    

#%%
def set_objects(root):   
    #print('Setting aRailML')
    #RML.aRailML = aRailML.aRailML()
    #RML.aRailML.Version = VERSION
    
    [child_1,tag_1] = get_leaves2(root)
    #print(child_1,tag_1)
    for i_1 in range(len(tag_1)):
        print('>'*1+f'{tag_1[i_1]}')
        #print(child_1[i_1])
        [child_2,tag_2] = get_leaves2(child_1[i_1])
        for i_2 in range(len(child_1[i_1])):
            print('>'*2+f'{tag_2[i_2]}')
            #print(child_2[i_2])
            [child_3,tag_3] = get_leaves2(child_2[0])
            for i_3 in range(len(child_2[0])):
                print('>'*3+f'{tag_3[i_3]}')
                #print(child_3[i_3])



    # print('>Metadata')
    # RML.Metadata = Metadata.Metadata()
    # metadata_set(root,'metadata',XMLNS_DC,RML.Metadata)
    # #print(RML.Metadata)
    
    # print('>Common')
    # #organizationalUnits
    # #positioning
    # RML.Common = Common.Common()
    # common_set(root,'common',XMLNS,RML.Common)  
    # #print(RML.Common)

def get_branches(root, level = 0):

    if level >= 2:
        return

    [child,tag] = get_leaves2(root)
    #print(child,tag)
    for i in range(len(tag)):
        print('>'*(level+1)+f'{tag[i]}')
        #print(child[i])
        get_branches(child[i],level+1)
    
def save_xml(file):    
    root_ML = ET.Element("railML",attrib = ATTRIBUTES)
    metadata_ML = ET.SubElement(root_ML, "metadata")

    metadata_to_XML(metadata_ML,RML.Metadata)
    
    tree2 = ET.ElementTree(root_ML)
    tree2.write(file)

    xmlstr = minidom.parseString(ET.tostring(root_ML)).toprettyxml(indent="   ", encoding='UTF-8')

    with open(file, "w") as f:
        f.write(str(xmlstr.decode('UTF-8')))
        f.close()
    
if __name__ == "__main__":
    root = load_xml("C:\PhD\RailML\Example_1.railml")   #A RELATIVE PATH DOESN'T WORK FOR PREVIEW!
    #set_objects(root)
    get_branches(root)       
    save_xml("C:\PhD\RailML\Example_2.railml")  #A RELATIVE PATH DOESN'T WORK FOR PREVIEW!