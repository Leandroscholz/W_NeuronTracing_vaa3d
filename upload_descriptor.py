from cytomine import Cytomine
from cytomine.utilities.descriptor_reader import read_descriptor

with Cytomine('https://biaflows.neubias.org/', 'f810cca7-ab02-439e-a1ca-d50a19be0064','0f379252-c606-4b2b-a29f-ed3618094b03') as c:
    read_descriptor("descriptor.json")