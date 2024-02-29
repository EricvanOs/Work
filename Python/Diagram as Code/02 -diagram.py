from diagrams import Diagram
from diagrams.aws.compute import EC2

with Diagram("Simple Diagram", outformat="svg"):
    EC2("web")