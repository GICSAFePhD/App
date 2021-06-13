import xml.etree.cElementTree as ET

import sys
sys.path.append('.')

from RailML.railML import bebida


#RailML\Example_1\src\example_1.xml

tree = ET.parse("RailML/Example1/src/example1.xml")
root = tree.getroot()

for child in root:
    print(f'{child.tag} | {child.attrib}')

#common = root.find('./{https://www.railml.org/schemas/3.1}common')

metadata = root.find('./{https://www.railml.org/schemas/3.1}metadata')

#for child in metadata:
#    print(ET.tostring(child, encoding='utf8').decode('utf8'))
   
for child in metadata:
    print(child.tag)   
    
#for child in common:
#    print(f'{child.tag} || {child.attrib}')

    