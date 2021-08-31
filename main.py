import sys
sys.path.append('.')
import xml.etree.cElementTree as ET
from xml.dom import XHTML_NAMESPACE, minidom
import re
import inspect
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
ATTRIBUTES = 0

RML = railML.railML()

IGNORE = {'Metadata','Common','Interlocking','Topology',
          'SignalsIS',
          'SwitchesIS',
          'Tracks',
          'TrainDetectionElements',
          'Borders','BufferStops'}

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

def get_branches(current_object, xml_node, level = 0, idx = "", idx_txt = 0):
    a = 0
    # xml_node: the old-tree
    # child[i]: the new-tree
    
    #if level >= 3:
    #    return
    
    #if len(idx) == 0:
    #    idx = 0
    #else:
    #    idx = int(idx)
    
    #if type(current_object) == list:
    #    print(f'LISTA:{xml_node}|{current_object[idx]}|{idx}')
    #    if len(current_object) > 1:
    #        current_object = current_object[idx+1]
        
    #print(f'OBJECT:{current_object}')                  
    if (type(current_object) != list and current_object != None):    
        if (xml_node.attrib):    
            #print(xml_node.attrib)         
            for tag_i in [*xml_node.attrib]:
                attribute_tag = tag_i[0].upper()+tag_i[1:]
                print(f'{current_object}|{attribute_tag} : {xml_node.attrib[tag_i]}')
                setattr(current_object,attribute_tag,xml_node.attrib[tag_i]) 
                
    [xml_child,xml_tag,xml_text] = get_leaves(xml_node)
    #print(xml_child,xml_tag,xml_text)
    object_attributes = get_attributes(current_object)
    #print(f'Attributes:{object_attributes}')
    #if xml_tag:
    #    print(f'Tags:{xml_tag}')

    size_xml_tag = len(xml_tag)

    for xml_tag_i in range(size_xml_tag):
        capitalized_tag = xml_tag[xml_tag_i][0].upper() + xml_tag[xml_tag_i][1:]
                
        if capitalized_tag in IGNORE:
            continue
        
        print(f'{capitalized_tag}|{capitalized_tag in object_attributes}')
        if (capitalized_tag in object_attributes):
            next_attribute_position = object_attributes.index(capitalized_tag)
            next_attribute = object_attributes[next_attribute_position]
            
            next_xml_child = xml_child[xml_tag_i] 
            #print(f'Next_child:{next_xml_child}')
                        
            print('>'*(level+1)+f'{xml_tag[xml_tag_i]}[{xml_tag_i+1} de {size_xml_tag}]') 
            if xml_text:
                #print(f'{text}|{text[idx_txt]}')
                constructors[xml_tag[xml_tag_i]](current_object,capitalized_tag,xml_text[idx_txt])
                idx_txt = idx_txt + 1
            else:
                print(f'TRYING:{xml_tag[xml_tag_i]}|{xml_tag[xml_tag_i] in constructors}')
                if xml_tag[xml_tag_i] in constructors:    
                    constructors[xml_tag[xml_tag_i]](current_object)
            #print(f'Constructor:{xml_tag_i}')
            #print(f'Next: {current_object.__class__.__name__}.{getattr(current_object, next_attribute)}')
            
            next_object = getattr(current_object,  next_attribute)
            #print(f'NEXT:{next_object}|||{xml_tag_i}')
            
            if(type(next_object) == list):
                if size_xml_tag == 1:
                    get_branches(next_object[0],next_xml_child,level+1)
                if xml_tag_i < size_xml_tag and 1 < size_xml_tag:
                    #print(f'----------------INCREMENTANDO:{xml_tag_i}[{idx}->{idx+1}]') 
                    #idx = idx + 1
                    get_branches(next_object[-1],next_xml_child,level+1)
            else:
                get_branches(next_object,next_xml_child,level+1,idx_txt=idx_txt)
        else:
            print(f'{capitalized_tag} doesn\'t exists! in {object_attributes}')
        
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
    try:
        attribute_inherated = []
        for i in type(object).mro()[:-1]:
            attribute_inherated += [j for j in i.__dict__ if not j.startswith('__') and not j.startswith('create')]
        print(attribute_inherated) 
        return attribute_inherated
    except:
        pass
    return [i for i in type(object).__dict__.keys() if not i.startswith('__') and not i.startswith('create')]

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

                'topology':railML.Infrastructure.Infrastructure.create_Topology,'geometry':railML.Infrastructure.Infrastructure.create_Geometry,'functionalInfrastructure':railML.Infrastructure.Infrastructure.create_FunctionalInfrastructure,'physicalFacilities':railML.Infrastructure.Infrastructure.create_PhysicalFacilities,'infrastructureVisualizations':railML.Infrastructure.Infrastructure.create_InfrastructureVisualizations,'infrastructureStates':railML.Infrastructure.Infrastructure.create_InfrastructureStates, # Infrastructure
                'netElements':railML.Infrastructure.Topology.Topology.create_NetElements, 'netRelations':railML.Infrastructure.Topology.Topology.create_NetRelations,'networks':railML.Infrastructure.Topology.Topology.create_Networks, # Topology
                'netElement':railML.Infrastructure.Topology.NetElements.NetElements.create_NetElement, # NetElements
                'tLengthM':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_tLengthM,'associatedPositioningSystem':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_AssociatedPositioningSystem,'elementCollectionOrdered':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_ElementCollectionOrdered,'elementCollectionUnordered':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_ElementCollectionUnordered,'isValid':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_IsValid,'name':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_Name,'relation':railML.Infrastructure.Topology.NetElements.NetElement.NetElement.create_Relation, # NetElement
                'positioningSystemRef':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_AssociatedPositioningSystem.create_PositioningSystemRef,'intrinsicCoordinate':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_AssociatedPositioningSystem.create_IntrinsicCoordinate,'isValid':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_AssociatedPositioningSystem.create_IsValid, # AssociatedPositionyngSystem
                
                'linearCoordinate':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_IntrinsicCoordinate.RTM_IntrinsicCoordinate.create_LinearCoordinate,'geometricCoordinate':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_IntrinsicCoordinate.RTM_IntrinsicCoordinate.create_GeometricCoordinate, # IntrinsicCoordinate
                'lateralSide':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_IntrinsicCoordinate.RTM_LinearCoordinate.RTM_LinearCoordinate.create_LateralSide,'verticalSide':railML.Infrastructure.Topology.NetElements.NetElement.RTM_AssociatedPositioningSystem.RTM_IntrinsicCoordinate.RTM_LinearCoordinate.RTM_LinearCoordinate.create_VerticalSide, # LinearCoordinate
                'elementPart':railML.Infrastructure.Topology.NetElements.NetElement.RTM_OrderedCollection.RTM_OrderedCollection.create_ElementPart, # ElementPart
                'navigability':railML.Infrastructure.Topology.NetElements.NetElement.RTM_Relation.RTM_Relation.create_Navigability,'positionOnA':railML.Infrastructure.Topology.NetElements.NetElement.RTM_Relation.RTM_Relation.create_PositionOnA,'positionOnB':railML.Infrastructure.Topology.NetElements.NetElement.RTM_Relation.RTM_Relation.create_PositionOnB,'elementA':railML.Infrastructure.Topology.NetElements.NetElement.RTM_Relation.RTM_Relation.create_ElementA,'elementB':railML.Infrastructure.Topology.NetElements.NetElement.RTM_Relation.RTM_Relation.create_ElementB, # Relation
                'netRelation':railML.Infrastructure.Topology.NetRelations.NetRelations.create_Relation, # NetRelations
                'network':railML.Infrastructure.Topology.Networks.Networks.create_Network, # Networks
                'level':railML.Infrastructure.Topology.Networks.Network.Network.create_Level,'networkResource':railML.Infrastructure.Topology.Networks.Network.RTM_Network.RTM_Network.create_NetworkResource, # RTM_Network
                
                'horizontalCurves':railML.Infrastructure.Geometry.Geometry.create_HorizontalCurves,'gradientCurves':railML.Infrastructure.Geometry.Geometry.create_GradientCurves,'geometryPoints':railML.Infrastructure.Geometry.Geometry.create_GeometryPoints, # Geometry
                'horizontalCurve':railML.Infrastructure.Geometry.HorizontalCurves.HorizontalCurves.create_HorizontalCurve, # HorizontalCurves
                'curveType':railML.Infrastructure.Geometry.HorizontalCurves.HorizontalCurve.HorizontalCurve.create_CurveType,'azimuth':railML.Infrastructure.Geometry.HorizontalCurves.HorizontalCurve.HorizontalCurve.create_Azimuth,'deltaAzimuth':railML.Infrastructure.Geometry.HorizontalCurves.HorizontalCurve.HorizontalCurve.create_DeltaAzimuth,'radius':railML.Infrastructure.Geometry.HorizontalCurves.HorizontalCurve.HorizontalCurve.create_Radius,'length':railML.Infrastructure.Geometry.HorizontalCurves.HorizontalCurve.HorizontalCurve.create_Length, # HorizontalCurve
                'gradienteCurve':railML.Infrastructure.Geometry.GradientCurves.GradientCurves.create_GradientCurve, # GradienteCurves
                'curveType':railML.Infrastructure.Geometry.GradientCurves.GradientCurve.GradientCurve.create_CurveType,'gradient':railML.Infrastructure.Geometry.GradientCurves.GradientCurve.GradientCurve.create_Gradient,'deltaGradient':railML.Infrastructure.Geometry.GradientCurves.GradientCurve.GradientCurve.create_DeltaGradient,'radius':railML.Infrastructure.Geometry.GradientCurves.GradientCurve.GradientCurve.create_Radius,'length':railML.Infrastructure.Geometry.GradientCurves.GradientCurve.GradientCurve.create_Length, # GradientCurve
                'geometryPoint':railML.Infrastructure.Geometry.GeometryPoints.GeometryPoints.create_GeometryPoint, # GeometryPoints
                'radius':railML.Infrastructure.Geometry.GeometryPoints.GeometryPoint.GeometryPoint.create_Radius,'gradient':railML.Infrastructure.Geometry.GeometryPoints.GeometryPoint.GeometryPoint.create_Gradient,'azimuth':railML.Infrastructure.Geometry.GeometryPoints.GeometryPoint.GeometryPoint.create_Azimuth, # GeometryPoint
                
                'balises':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Balises,'borders':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Borders,'bufferStops':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_BufferStops,'crossings':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Crossings,'derailersIS':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_DerailersIS,'electrifications':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Electrifications,'keyLocksIS':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_KeyLocksIS,'levelCrossingsIS':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_LevelCrossingsIS,'lines':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Lines,'loadingGauges':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_LoadingGauges,'operationalPoints':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_OperationalPoints,'overCrossings':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_OverCrossings,'platforms':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Platforms,'restrictionAreas':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_RestrictionAreas,'serviceSections':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_ServiceSections,'signalsIS':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_SignalsIS,'speeds':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Speeds,'stoppingPlaces':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_StoppingPlaces,'switchesIS':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_SwitchesIS,'tracks':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_Tracks,'trackBeds':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_TrackBeds,'trackGauges':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_TrackGauges,'trainDetectionElements':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_TrainDetectionElements,'trainProtectionElements':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_TrainProtectionElements,'trainRadios':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_TrainRadios,'underCrossing':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_UnderCrossings,'weightLimits':railML.Infrastructure.FunctionalInfrastructure.FunctionalInfrastructure.create_WeightLimits, # FunctionalInfrastructure
                
                'balise':railML.Infrastructure.FunctionalInfrastructure.Balises.Balises.create_Balise, # Balises
                'type':railML.Infrastructure.FunctionalInfrastructure.Balises.Balise.Balise.create_Type,'belongsToParent':railML.Infrastructure.FunctionalInfrastructure.Balises.Balise.Balise.create_BelongsToParent,'basedOnTemplate':railML.Infrastructure.FunctionalInfrastructure.Balises.Balise.Balise.create_BasedOnTemplate,'baliseGroupType':railML.Infrastructure.FunctionalInfrastructure.Balises.Balise.Balise.create_BaliseGroupType, # Balise         
                
                'border':railML.Infrastructure.FunctionalInfrastructure.Borders.Borders.create_Border, # Borders
                'type':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_Type,'id':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_Id, # Border 
                'designator':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_Designator,
                'external':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_External,
                'name':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_Name,
                'gmlLocations':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_GmlLocations,
                'locationNetwork':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_LocationNetwork,
                'areaLocation':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_AreaLocation,
                'linearLocation':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_LinearLocation,
                'spotLocation':railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.create_SpotLocation,
                
                'bufferstop':railML.Infrastructure.FunctionalInfrastructure.BufferStops.BufferStops.create_BufferStop, # BufferStops
                'type':railML.Infrastructure.FunctionalInfrastructure.BufferStops.BufferStop.BufferStop.create_Type, # BufferStop
                
                'crossing':railML.Infrastructure.FunctionalInfrastructure.Crossings.Crossings.create_Crossing, # Crossings
                'derailerIS':railML.Infrastructure.FunctionalInfrastructure.DerailersIS.DerailersIS.create_DerailerIS, # DerailersIS
                'derailSide':railML.Infrastructure.FunctionalInfrastructure.DerailersIS.DerailerIS.DerailerIS.create_DerailSide, # DerailerIs
                
                'electrificationSection':railML.Infrastructure.FunctionalInfrastructure.Electrifications.Electrifications.create_ElectrificationSection, # Electrifications
                'contactLineType':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_ContactLineType,'isInsulatedSection':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_IsInsulatedSection,'belongsToParent':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_BelongsToParent,'electrificationSystemRef':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_ElectrificationSystemRef,'energyCatenary':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_EnergyCatenary,'energyPantograph':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_EnergyPantograph,'energyRollingstock':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_EnergyRollingstock,'contactWire':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_ContactWire,'pantographSpacingn':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection. create_PantographSpacingn,'phaseSeparationSection':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_PhaseSeparationSection,'systemSeparationSection':railML.Infrastructure.FunctionalInfrastructure.Electrifications.ElectrificationSection.ElectrificationSection.create_SystemSeparationSection, # ElectrificationSection

                'keyLockIS':railML.Infrastructure.FunctionalInfrastructure.KeyLocksIS.KeyLocksIS.create_KeyLockIS, # KeyLocksIS
                'levelCrossingIS':railML.Infrastructure.FunctionalInfrastructure.LevelCrossingsIS.LevelCrossingsIS.create_LevelCrossingIS, # LevelCrossingsIS
                'protection':railML.Infrastructure.FunctionalInfrastructure.LevelCrossingsIS.LevelCrossingIS.LevelCrossingIS.create_Protection, # LevelCrossingIS
                
                'line':railML.Infrastructure.FunctionalInfrastructure.Lines.Lines.create_Line, # Lines
                'beginsInOP':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line.create_BeginsInOP,'endsInOP':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line.create_EndsInOP,'length':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line.create_Length,'lineTrafficCode':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line.create_LineTrafficCode,'lineCombinedTransportCode':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line.create_LineCombinedTransportCode,'lineLayout':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line.create_LineLayout,'linePerformance':railML.Infrastructure.FunctionalInfrastructure.Lines.Line.Line. create_LinePerformance, # Line

                'loadingGauge':railML.Infrastructure.FunctionalInfrastructure.LoadingGauges.LoadingGauges.create_LoadingGauge, # LoadingGauges
                'operationalPoint':railML.Infrastructure.FunctionalInfrastructure.OperationalPoints.OperationalPoints.create_OperationalPoint, # OperationalPoints
                'infrastructureManagerRef':railML.Infrastructure.FunctionalInfrastructure.OperationalPoints.OperationalPoint.OperationalPoint.create_InfrastructureManagerRef,'connectedToLine':railML.Infrastructure.FunctionalInfrastructure.OperationalPoints.OperationalPoint.OperationalPoint.create_ConnectedToLine,'limitedByBorder':railML.Infrastructure.FunctionalInfrastructure.OperationalPoints.OperationalPoint.OperationalPoint.create_LimitedByBorder,'opEquipment':railML.Infrastructure.FunctionalInfrastructure.OperationalPoints.OperationalPoint.OperationalPoint.create_OpEquipment,'opOperations':railML.Infrastructure.FunctionalInfrastructure.OperationalPoints.OperationalPoint.OperationalPoint.create_OpOperations, # OperationalPoint
                
                'overCrossing':railML.Infrastructure.FunctionalInfrastructure.OverCrossings.OverCrossings.create_OverCrossing, # OverCrossings
                'allowedLoadingGauge':railML.Infrastructure.FunctionalInfrastructure.OverCrossings.OverCrossing.OverCrossing.create_AllowedLoadingGauge,'length':railML.Infrastructure.FunctionalInfrastructure.OverCrossings.OverCrossing.OverCrossing.create_Length, # OverCrossing
                
                'platform':railML.Infrastructure.FunctionalInfrastructure.Platforms.Platforms.create_Platform, # Platforms
                'ownsPlatformEdge':railML.Infrastructure.FunctionalInfrastructure.Platforms.Platform.Platform.create_OwnsPlatformEdge,'width':railML.Infrastructure.FunctionalInfrastructure.Platforms.Platform.Platform.create_Width,'length':railML.Infrastructure.FunctionalInfrastructure.Platforms.Platform.Platform.create_Length, # Platform
                
                'restrictionArea':railML.Infrastructure.FunctionalInfrastructure.RestrictionAreas.RestrictionAreas.create_RestrictionArea, # RestrictionAreas
                'serviceSection':railML.Infrastructure.FunctionalInfrastructure.ServiceSections.ServiceSections.create_ServiceSection, # ServiceSections
                
                'signalIS':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalsIS.create_SignalIS, # SignalsIS
                'isSignalAnnouncement':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalAnnouncement,'isSignalCatenary':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalCatenary,'isSignalDanger':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalDanger,'isSignalEtcs':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalEtcs,'isSignalInformation':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalInformation,'isSignalLevelCrossing':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalLevelCrossing,'isSignalMilepost':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalMilepost,'isSignalSpeed':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalSpeed,'isSignalStopPost':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalStopPost,'isSignalTrainMovement':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalTrainMovement,'isSignalRadio':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalRadio,'isSignalVehicleEquipment':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_IsSignalVehicleEquipment,'connectedWithBaliseGroup':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_ConnectedWithBaliseGroup,'signalConstruction':railML.Infrastructure.FunctionalInfrastructure.SignalsIS.SignalIS.SignalIS.create_SignalConstruction, # SignalIS
                
                'speedSection':railML.Infrastructure.FunctionalInfrastructure.Speeds.Speeds.create_SpeedSection, # Speeds
                'validForSpeedProfil':railML.Infrastructure.FunctionalInfrastructure.Speeds.SpeedSection.SpeedSection.create_ValidForSpeedProfile, # SpeedSection
                
                'stoppingPlace':railML.Infrastructure.FunctionalInfrastructure.StoppingPlaces.StoppingPlaces.create_StoppingPlace, # StoppingPlaces
                'validForTrainMovement':railML.Infrastructure.FunctionalInfrastructure.StoppingPlaces.StoppingPlace.StoppingPlace.create_ValidForTrainMovement, # StoppingPlace
                
                'switchIS':railML.Infrastructure.FunctionalInfrastructure.SwitchesIS.SwitchesIS.create_SwitchIS, # SwitchesIS
                
                'leftBranch':railML.Infrastructure.FunctionalInfrastructure.SwitchesIS.SwitchIS.SwitchIS.create_LeftBranch,
                'rightBranch':railML.Infrastructure.FunctionalInfrastructure.SwitchesIS.SwitchIS.SwitchIS.create_RightBranch,
                'straightBranch':railML.Infrastructure.FunctionalInfrastructure.SwitchesIS.SwitchIS.SwitchIS.create_StraightBranch,
                'turningBranch':railML.Infrastructure.FunctionalInfrastructure.SwitchesIS.SwitchIS.SwitchIS.create_TurningBranch, # SwitchIS

                'track':railML.Infrastructure.FunctionalInfrastructure.Tracks.Tracks.create_Track, # Tracks
                'trackBegin':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.Track.create_TrackBegin,'trackEnd':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.Track.create_TrackEnd,'length':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.Track.create_Length,'linearLocation':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.Track.create_LinearLocation, # Track
                'associatedNetElement':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.RTM_LinearLocation.RTM_LinearLocation.create_AssociatedNetElement,'linearCoordinate':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.RTM_LinearLocation.RTM_LinearLocation.create_LinearCoordinate,'geometricCoordinate':railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.RTM_LinearLocation.RTM_LinearLocation.create_GeometricCoordinate, # LinearLocation
    
                'trackBed':railML.Infrastructure.FunctionalInfrastructure.TrackBeds.TrackBeds.create_TrackBed, # TrackBeds
                'trackGauge':railML.Infrastructure.FunctionalInfrastructure.TrackGauges.TrackGauges.create_TrackGauge, # TrackGauges
                'trainDetectionElement':railML.Infrastructure.FunctionalInfrastructure.TrainDetectionElements.TrainDetectionElements.create_TrainDetectionElement, # TrainDetectionElements
                'trainProtectionElement':railML.Infrastructure.FunctionalInfrastructure.TrainProtectionElements.TrainProtectionElements.create_TrainProtectionElement, # TrainProtectionElements
                'trainRadio':railML.Infrastructure.FunctionalInfrastructure.TrainRadios.TrainRadios.create_TrainRadio, # TrainRadios
                
                'underCrossing':railML.Infrastructure.FunctionalInfrastructure.UnderCrossings.UnderCrossings.create_UnderCrossing, # UnderCrossings
                'allowedLoadingGauge':railML.Infrastructure.FunctionalInfrastructure.UnderCrossings.UnderCrossing.UnderCrossing.create_AllowedLoadingGauge,'length':railML.Infrastructure.FunctionalInfrastructure.UnderCrossings.UnderCrossing.UnderCrossing.create_Length, # UnderCrossing
                
                'weightLimit':railML.Infrastructure.FunctionalInfrastructure.WeightLimits.WeightLimits.create_WeightLimit, # WeightLimits

                'visualization':railML.Infrastructure.InfrastructureVisualizations.InfrastructureVisualizations.create_Visualization, # InfrastructureVisualizations
                'spotElementProjection':railML.Infrastructure.InfrastructureVisualizations.Visualization.Visualization.create_SpotElementProjection,'linearElementProjection':railML.Infrastructure.InfrastructureVisualizations.Visualization.Visualization.create_LinearElementProjection,'areaElementProjection':railML.Infrastructure.InfrastructureVisualizations.Visualization.Visualization.create_AreaElementProjection, # Visualization

                'coordinate':railML.Infrastructure.InfrastructureVisualizations.Visualization.SpotProjection.SpotProjection.create_Coordinate, 
                'usesSymbol':railML.Infrastructure.InfrastructureVisualizations.Visualization.SpotProjection.SpotProjection.create_UsesSymbol, # SpotProjection
                'coordinate':railML.Infrastructure.InfrastructureVisualizations.Visualization.LinearProjection.LinearProjection.create_Coordinate, # LinearProjection
                'coordinate':railML.Infrastructure.InfrastructureVisualizations.Visualization.AreaProjection.AreaProjection.create_Coordinate, # SpotProjection

                'infrastructureState':railML.Infrastructure.InfrastructureStates.InfrastructureStates.create_InfrastructureState, # InfrastructureStates
                'elementState':railML.Infrastructure.InfrastructureStates.InfrastructureState.InfrastructureState.create_ElementState,'validityTime':railML.Infrastructure.InfrastructureStates.InfrastructureState.InfrastructureState.create_ValidityTime, # InfrastructureState
                'validityTime':railML.Infrastructure.InfrastructureStates.InfrastructureState.ElementState.ElementState.create_ValidityTime, # ElementState            
                'period':railML.Infrastructure.InfrastructureStates.InfrastructureState.Period.Period.create_Period,'periodBitmask':railML.Infrastructure.InfrastructureStates.InfrastructureState.Period.Period.create_PeriodBitmask,'periodGeneric':railML.Infrastructure.InfrastructureStates.InfrastructureState.Period.Period.create_PeriodGeneric, # Period
                'periodRule':railML.Infrastructure.InfrastructureStates.InfrastructureState.Period.CalendarTimePeriodWithBitmask.CalendarTimePeriodWithBitmask.create_PeriodRule, # CalendarTimePeriodWithBitmask
                'period':railML.Infrastructure.InfrastructureStates.InfrastructureState.Period.CalendarTimePeriodWithBitmask.PeriodRule.PeriodRule.create_Period, # PeriodRule
                
                
                
                
                
                
                
                
                
                }


if __name__ == "__main__":
    root = load_xml("F:\PhD\RailML\Example_1.railml")   #A RELATIVE PATH DOESN'T WORK FOR PREVIEW!

    get_branches(RML,root)
    #TODO Topology pointer connection
    
    #print(railML.Infrastructure.FunctionalInfrastructure.Borders.Border.Border.__dict__)
    
    #railML.Common.PositioningSystems.GeometricPositioningSystems.GeometricPositioningSystems.RTM_GeometricPositioningSystem
    
    #x = railML.Infrastructure.FunctionalInfrastructure.Tracks.Track

    #print(railML.Infrastructure.FunctionalInfrastructure.Tracks.Track.Track.__dict__)
    #attribute_inherated = []
    #for i in type(x).mro()[:-1]:
        #print(i.__dict__)
    #    attribute_inherated += [j for j in i.__dict__ if not j.startswith('__')]
    #print(attribute_inherated) 
    
    
    
    
    
    #save_xml("F:\PhD\RailML\Example_2.railml")  #A RELATIVE PATH DOESN'T WORK FOR PREVIEW!
# %%
