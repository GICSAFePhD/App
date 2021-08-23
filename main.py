import sys
sys.path.append('.')
import xml.etree.cElementTree as ET
from xml.dom import minidom
import re
from RailML import railML
from RailML.Common import Metadata
from RailML.Common import Common
from RailML.Infrastructure import Infrastructure
from RailML.Interlocking import Interlocking
from RailML import aRailML

#XMLNS = "https://www.railml.org/schemas/3.1"
#XMLNS_DC ="http://purl.org/dc/elements/1.1/"
#XMLNS_GML="http://www.opengis.net/gml/3.2/"
#XMLNS_XSI="http://www.w3.org/2001/XMLSchema-instance"
#XSI_SCHEMALOCATION="https://www.railml.org/schemas/3.1 https://www.railml.org/schemas/3.1/railml3.xsd"
#VERSION = "3.1"

#ATTRIBUTES = {"xmlns":XMLNS , "xmlns:dc":XMLNS_DC , "xmlns:gml":XMLNS_GML , "xmlns:xsi":XMLNS_XSI , "xsi:schemaLocation":XSI_SCHEMALOCATION , "version":VERSION}

RML = railML.railML()

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

def get_leaves(root):
    leaves = []
    leaf = []
    text = []
    #ns_leaf = '{'+tag+'}'
    
    for i in root:  # HERE I CAN DO IT GENERIC
        ns = re.match(r'{.*}', i.tag).group(0)
        leaves.append(i.tag[len(ns):])
        leaf.append(i)
        
        if i.text and i.text[0] != '\n':
            text.append(i.text)
    
    return [leaf,leaves,text]

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

def get_branches(object, root, level = 0, idx = 0, idx_txt = 0):

    # root: the old-tree
    # child[i]: the new-tree
    
    #if level >= 3:
    #    return
    
    if type(object) == list:
        #print(f'LISTA:{root}|{object[idx]}|{idx}')
        if len(object) > 1:
            object = object[idx+1]
        
    print(f'OBJECT:{object}|{idx}')                  
    if (type(object) != list):    
        if (root.attrib):    
            #print(root.attrib)         
            for j in [*root.attrib]:
                #print(f'{j} : {root.attrib[j]}')
                setattr(object,j[0].upper()+j[1:],root.attrib[j]) 
                
    [child,tag,text] = get_leaves(root)
    #print(child,tag,text)
    attributes = get_attributes(object)
    #print(f'Attributes:{attributes}|{tag}')

    for i in tag:
        capitalized_tag = i[0].upper() + i[1:]
        #print(f'TEST:{capitalized_tag}|{i.title()}||{capitalized_tag in attributes}')
        #print(f'TAG:{tag}')
        if capitalized_tag == "Metadata":
            continue
        if capitalized_tag == "Common":
            continue
        #if capitalized_tag == "Infrastructure":
        #    continue
        if capitalized_tag == "Interlocking":
            continue
        
        if (capitalized_tag in attributes):
            next = attributes.index(i[0].upper() + i[1:])
            prev = find(tag,i)
            print(f'Trying to create:{attributes[next]}|{i}|{i in constructors}')
            
            if i in constructors:
                for p in prev:   
                    #print(f'PREV:{prev}|{idx}')
                    if idx < len(prev):
                        print('>'*(level+1)+f'{i}') 
                        if text:
                            #print(f'{text}|{text[idx_txt]}')
                            constructors[i](object,i[0].upper() + i[1:],text[idx_txt])
                            idx_txt = idx_txt + 1
                        else:    
                            constructors[i](object)
                        print(f'Constructor:{i}')
                        #print(f'Next: {object.__class__.__name__}.{getattr(object, attributes[next])}')
                        
                        next_object = getattr(object,  attributes[next])
                        #print(f'NEXT:{next_object}|||{idx}')
                        
                        if(type(next_object) == list):
                            if len (prev) == 1:
                                get_branches(next_object[0],child[p],level+1)
                            if idx < len(prev) and 1 < len(prev):
                                idx = idx + 1
                                get_branches(next_object[-1],child[p],level+1,idx)
                        else:
                            get_branches(next_object,child[p],level+1,idx_txt=idx_txt)

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
    
def get_attributes(object):
    return [i for i in type(object).__dict__.keys() if (i[:1] != '_' and i[:1] != 'c')]

def set_text(object,tag,text):
    setattr(object,tag,text)

    
    
constructors = {'metadata':railML.railML.create_metadata,'common':railML.railML.create_common,'infrastructure':railML.railML.create_infrastructure,'interlocking':railML.railML.create_interlocking, # RailML
                'title':set_text,'date':set_text,'creator':set_text,'source':set_text,'identifier':set_text,'subject':set_text,'format':set_text,'description':set_text,'publisher':set_text,   # Metadata
                
                
                
                'electrificationSystems':railML.Common.Common.create_ElectrificationSystems,'organizationalUnits':railML.Common.Common.create_OrganizationalUnits,'speedProfiles':railML.Common.Common.create_SpeedProfiles,'positioning':railML.Common.Common.create_PositioningSystems,  # Common
                'electrificationSystem':railML.Common.ElectrificationSystems.ElectrificationSystems.create_ElectrificationSystem, # ElectrificationSystems
                'tVoltageVolt':railML.Common.ElectrificationSystems.ElectrificationSystem.ElectrificationSystem.create_tVoltageVolt,'frequencyHertz':railML.Common.ElectrificationSystems.ElectrificationSystem.ElectrificationSystem.create_tFrequencyHertz, # ElectrificationSystem              
                'infrastructureManager':railML.Common.OrganizationalUnits.OrganizationalUnits.create_InfrastructureManager,'vehicleManufacturer':railML.Common.OrganizationalUnits.OrganizationalUnits.create_VehicleManufacturer,'vehicleOperator':railML.Common.OrganizationalUnits.OrganizationalUnits.create_VehicleOperator,'customer':railML.Common.OrganizationalUnits.OrganizationalUnits.create_Customer,'railwayUndertaking':railML.Common.OrganizationalUnits.OrganizationalUnits.create_RailwayUndertaking,'operationalUndertaking':railML.Common.OrganizationalUnits.OrganizationalUnits.create_OperationalUndertaking,'concessionaire':railML.Common.OrganizationalUnits.OrganizationalUnits.create_Concessionaire,'contractor':railML.Common.OrganizationalUnits.OrganizationalUnits.create_Contractor, # OrganizationalUnits  
                'speedfprofiles':railML.Common.SpeedProfiles.SpeedProfiles.create_SpeedProfile, # SpeedProfiles
                'speedProfileTilting':railML.Common.SpeedProfiles.SpeedProfile.SpeedProfile.create_SpeedProfileTilting,'speedProfileLoad':railML.Common.SpeedProfiles.SpeedProfile.SpeedProfile.create_SpeedProfileLoad,'speedProfileBraking':railML.Common.SpeedProfiles.SpeedProfile.SpeedProfile.create_SpeedProfileBraking,'speedProfileTrainType':railML.Common.SpeedProfiles.SpeedProfile.SpeedProfile.create_SpeedProfileTrainType, # SpeedProfile
                'geometricPositioningSystems':railML.Common.PositioningSystems.PositioningSystems.create_GeometricPositioningSystems,'linearPositioningSystems':railML.Common.PositioningSystems.PositioningSystems.create_LinearPositioningSystems,'screenPositioningSystems':railML.Common.PositioningSystems.PositioningSystems.create_ScreenPositioningSystems, # PositioningSystems
                'geometricPositioningSystem':railML.Common.PositioningSystems.GeometricPositioningSystems.GeometricPositioningSystems.create_GeometricPositioningSystem, # GeometricPositioningSystems
                'linearPositioningSystem':railML.Common.PositioningSystems.LinearPositioningSystems.LinearPositioningSystems.create_LinearPositioningSystem, # LinearPositioningSystem
                'screenPositioningSystem':railML.Common.PositioningSystems.ScreenPositioningSystems.ScreenPositioningSystems.create_ScreenPositioningSystem, # ScreenPositioningSystems
                'name':railML.Common.PositioningSystems.GeometricPositioningSystems.GeometricPositioningSystem.GeometricPositioningSystem.create_Name,'isValid':railML.Common.PositioningSystems.GeometricPositioningSystems.GeometricPositioningSystem.GeometricPositioningSystem.create_IsValid, # GeometricPositioningSystem

                'topology':railML.Infrastructure.Infrastructure.create_Topology,#'geometry':railML.Infrastructure.Infrastructure.create_Geometry,'functionalInfrastructure':railML.Infrastructure.Infrastructure.create_FunctionalInfrastructure,'physicalFacilities':railML.Infrastructure.Infrastructure.create_PhysicalFacilities,'infrastructureVisualizations':railML.Infrastructure.Infrastructure.create_InfrastructureVisualizations,'infrastructureStates':railML.Infrastructure.Infrastructure.create_InfrastructureStates, # Infrastructure
                'netElements':railML.Infrastructure.Topology.Topology.create_NetElements, 'netRelations':railML.Infrastructure.Topology.Topology.create_NetRelations,'network':railML.Infrastructure.Topology.Topology.create_Networks, # Topology
                'netElement':railML.Infrastructure.Topology.NetElements.NetElements.create_NetElement, # NetElements
                #'tLengthM':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_tLengthM,'associatedPositioningSystem':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_AssociatedPositioningSystem,'elementCollectionOrdered':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_ElementCollectionOrdered,'elementCollectionUnordered':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_ElementCollectionUnordered,'isValid':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_IsValid,'name':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_Name,
                'relation':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_Relation, # NetElement
                
                
                
                
                
                
                }





def find(lst, a):
    result = []
    for i, x in enumerate(lst):
        if x == a:
            result.append(i)
    return result

if __name__ == "__main__":
    root = load_xml("F:\PhD\RailML\Example_1.railml")   #A RELATIVE PATH DOESN'T WORK FOR PREVIEW!

    get_branches(RML,root)
    
    #railML.Common.PositioningSystems.GeometricPositioningSystems.GeometricPositioningSystems.RTM_GeometricPositioningSystem
    
    #x = get_attributes(railML.Common.PositioningSystems.GeometricPositioningSystems) 

    #print(x)



    #save_xml("F:\PhD\RailML\Example_2.railml")  #A RELATIVE PATH DOESN'T WORK FOR PREVIEW!
# %%
