import { v4 } from "uuid";

export const DEFAULT_TEXTNODE_WIDTH = 120;
export const DEFAULT_TEXTNODE_HEIGHT = 30;
export const DEFAULT_NODE_WIDTH = 80;
export const DEFAULT_NODE_THICKNESS = 20;
export const DEFAULT_NODE_INITIALX = 5;
export const DEFAULT_NODE_INITIALY = 15;
export const DEFAULT_NODE_SPACING = 60;

export class MermaidLexer {

    private _context : CanvasRenderingContext2D | null;

    public constructor() {
        const canvas = document.createElement("canvas");
        this._context = canvas.getContext("2d");
        if (this._context) {
            this._context.font = "16px serif";
        }
    }

    public parse(content: string) {
        content = content.trim();
        if (content.startsWith("flowchart")) {
            const index = content.indexOf("\n");
            if (index > -1) {
                const text = content.substring(index);
                return this.parseFlowChart(text);
            }
        } else if (content.startsWith("sequenceDiagram")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("classDiagram")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("stateDiagram-v2")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("erDiagram")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("journey")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("gantt")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("pie")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("quadrantChart")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("requirementDiagram")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("gitGraph")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("C4Context")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("mindmap")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("timeline")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("zenuml")) {
            console.error("Mermaid graph not actually supported");
        } else if (content.startsWith("sankey-beta")) {
            console.error("Mermaid graph not actually supported");
        } else {
            console.error("Invalid Mermaid graph")
        }
        return null;
    }

    private parseFlowChart(content: string) {
        const index = content.indexOf("\n");
        const graph = { id: v4(), type: "FlowChart", title: "", orientation: "LR", width: 0, nodes: [] } as IMermaidFlowChart;
        let tokens : IMermaidToken[] = [];
        let text = content.substring(index);
        while (text) {
            let token = null;
            // Relationship
            if (token = this.generateFlowChartRelationship(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Node
            } else if (token = this.generateFlowChartNode(text)) {
                text = text.substring(token.raw.length);
                graph.nodes.push(token);
            } else {
                console.error(text.length);
                console.error("Invalid type: ", text);
                break;
            }
        }

        // Identify position for each node
        let previousNode : IFlowChartNode | null = null;
        graph.nodes.forEach(n => {
            this.compteNodeProperties(n, previousNode);
            previousNode = n;
        });
        if (graph.nodes.length > 0) {
            graph.width = graph.nodes[graph.nodes.length-1].positionX + graph.nodes[graph.nodes.length-1].width;
        }

        //graph.tokens = tokens;
        return graph;
    }

    private generateFlowChartNode(text: string) {
        const match = flowChartNode.exec(text);
        if (match) {
            let nodeTitle = "";
            let nodeType : FlowChartNodeType = "SQUARE";
            if (match.length > 4) {
                nodeTitle = match[3];
                nodeType = this.determineNodeType(match[2], match[4]);
            }
            const token = { id: v4(), type: "Node", raw: match[0] ,nodeId: match[1], nodeType: nodeType, title: nodeTitle } as IFlowChartNode;
            return token;
        } else {
            return null;
        }
    }

    private determineNodeType(separator1: string, separator2: string) : FlowChartNodeType {
        if (separator1 === "(" && separator2 === ")") {
            return "ROUND_EDGE";
        } else if (separator1 === "([" && separator2 === "])") {
            return "STADIUM_SHAPED";
        } else if (separator1 === "[[" && separator2 === "]]") {
            return "ROUND_EDGE";
        } else if (separator1 === "[(" && separator2 === ")]") {
            return "CYLINDRICAL";
        } else if (separator1 === "((" && separator2 === "))") {
            return "CIRCLE";
        } else if (separator1 === ">" && separator2 === "]") {
            return "ASYMMETRIC";
        } else if (separator1 === "{" && separator2 === "}") {
            return "RHOMBUS";
        } else if (separator1 === "{{" && separator2 === "}}") {
            return "HEXAGON";
        } else if (separator1 === "[/" && separator2 === "/]") {
            return "PARALLELOGRAM";
        } else if (separator1 === "[\\" && separator2 === "\\]") {
            return "PARALLELOGRAM_ALT";
        } else if (separator1 === "[/" && separator2 === "\\]") {
            return "TRAPEZOID";
        } else if (separator1 === "[\\" && separator2 === "/]") {
            return "TRAPEZOID_ALT";
        } else if (separator1 === "(((" && separator2 === ")))") {
            return "DOUBLE_CIRCLE";
        } else {
            return "SQUARE";
        }
    }

    private generateFlowChartRelationship(text: string) {
        const match = flowChartRelationship.exec(text);
        if (match) {
            const token = { id: v4(), type: "Relationship", raw: match[0], startToken: match[1], endToken: match[2] } as IFlowChartRelationship;
            return token;
        } else {
            return null;
        }
    }

    private compteNodeProperties(node: IFlowChartNode, previousNode: IFlowChartNode | null) {

        // Define title with node id if not defined
        if (!node.title) { node.title = node.nodeId; }

        // Compute width
        const measure = this.measureText(node.title);
        node.textWidth = measure?.width || DEFAULT_TEXTNODE_WIDTH;
        node.width =  Math.abs(Math.max(node.textWidth, DEFAULT_NODE_WIDTH) + DEFAULT_NODE_THICKNESS);

        // Position
        const previousPosition = previousNode ? previousNode.positionX + previousNode.width + DEFAULT_NODE_SPACING : 0;
        node.positionX = DEFAULT_NODE_INITIALX + previousPosition;
        node.positionY = DEFAULT_NODE_INITIALY;
        node.textPositionX = node.positionX + (node.width - node.textWidth) / 2;
        node.textPositionY = node.positionY + 30;
    }

    private measureText(text: string) {
        if (this._context) {
            return this._context.measureText(text);
        } else {
            return null;
        }
    }
}



export interface IMermaidGraph {
    id: string;
    type: MermaidGraphType;
}

export interface IMermaidToken {
    id: string;
    type: MermaidType;
    raw: string;
}

export interface IMermaidFlowChart extends IMermaidGraph {
    title: string;
    orientation: FlowChartOrientation;
    width: number;
    //tokens: IMermaidToken[];
    nodes: IFlowChartNode[];
}

export interface IFlowChartNode extends IMermaidToken{
    nodeId: string;
    title: string;
    nodeType: FlowChartNodeType;
    order: number;
    positionX: number;
    positionY: number;
    textPositionX : number;
    textPositionY : number;
    width: number;
    textWidth: number;
    textHeight: number;
}
export type FlowChartNodeType = "SQUARE" | "ROUND_EDGE" | "STADIUM_SHAPED" | "SUBROUTINE" | "CYLINDRICAL" | "CIRCLE" | "ASYMMETRIC" | 
    "RHOMBUS" | "HEXAGON" | "PARALLELOGRAM" | "PARALLELOGRAM_ALT" | "TRAPEZOID" | "TRAPEZOID_ALT" | "DOUBLE_CIRCLE";

export interface IFlowChartRelationship extends IMermaidToken {
    startToken: string;
    endToken: string;
}

export type MermaidGraphType = "FlowChart";
export type MermaidType = "Relationship"| "Node";
export type FlowChartOrientation = "TB" | "TD" | "BT" | "RL" | "LR";

const flowChartNode = /^\s*([a-z|A-Z|0-9]+)(?:(\(\(\(|\[\/|\[\\|\{\{|\(\[|\[\[|\(\(|\(|\[|>|\{)(.+?)(\)\)\)|\/\]|\\\]|\}\}|\]\)|\]\]|\)\)|\)|\]|\}))?/;

const flowChartRelationship = /\s*([a-z|A-Z|0-9]+)-->([a-z|A-Z|0-9]+);/;