import { v4 } from "uuid";
import { FlowChartOrientation, IMermaidFlowChart, IMermaidGraph, MermaidGraphType, MermaidLexer } from "./mermaidLexer";

export class MarkdownLexer {

    private _mermaidLexer : MermaidLexer;

    constructor() {
        this._mermaidLexer = new MermaidLexer();
    }

    public parse(content: string) {
        let tokens : IMarkdownToken[] = [];
        let text = content.replace(/\r\n|\r/g, '\n');
        while (text) {
            let token = null;

            // Newline
            if (token = this.generateSpaceToken(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Heading
            } else if (token = this.generateHeadingToken(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Mermaid
            } else if (token = this.generateMermaid(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Fence
            } else if (token = this.generateFenceToken(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Checklist
            } else if (token = this.generateCheckList(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Unordered list
            } else if (token = this.generateUnorderedList(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // ordered list
            } else if (token = this.generateOrderedList(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Table
            } else if (token = this.generateTable(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // BlockQuote
            } else if (token = this.generateBlockquote(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Paragraph
            } else if (token = this.generateParagraph(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            } else {
                console.error("Invalid type: ", text);
                break;
            }
            
        }
        return tokens;
    }

    private parseInline(content: string) {
        let tokens : IMarkdownToken[] = [];
        let text = content;
        while (text) {
            let token = null;

            // Link
            if (token = this.generateLink(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Bold
            } else if (token = this.generateBold(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Italic
            } else if (token = this.generateItalic(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // StrikeThrough
            } else if (token = this.generateStrikeThrough(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            // Text
            } else if (token = this.generateText(text)) {
                text = text.substring(token.raw.length);
                tokens.push(token);
            } else {
                console.error("Invalid type: ", text);
                break;
            }
        }
        return tokens;
    }

    private generateSpaceToken(text: string) : IMarkdownSpaceToken | null {
        const match = newlineRegex.exec(text);
        if (match && match[0].length > 0 ) {
            return { id: v4(),  type: "Space", raw: match[0] }
        } else {
            return null;
        }
    }

    private generateHeadingToken(text: string) : IMarkdownHeadingToken | null {
        const match = headingRegex.exec(text);
        if (match) {
            return { id: v4() ,type: "Heading", raw: match[0], level: match[1].length, tokens: match[2].trim() }
        } else {
            return null;
        }
    }

    private generateFenceToken(text: string) : IMarkdownFenceToken | null {
        const match = fenceRegex.exec(text);
        if (match) {
            return { id: v4() ,type: "Fence", raw: match[0], code: match[3].trim() }
        } else {
            return null;
        }
    }

    private generateUnorderedList(text: string) : IMarkdownUnorderedListToken | null {
        let content = text;
        const match = unorderedlistRegex.exec(content);
        if (match) {
            const token = { id: v4(), type: "UnorderedList", raw: "", tokens: [] } as IMarkdownUnorderedListToken;
            while (content) {
                const match = unorderedlistRegex.exec(content);
                if (match) {
                    const raw = match[0];
                    token.raw += raw;
                    token.tokens.push(match[2]);
                    content = content.substring(raw.length);
                } else {
                    break;
                }
            }
            return token;
        } else {
            return null;
        }
    }

    private generateOrderedList(text: string) : IMarkdownOrderedListToken | null {
        let content = text;
        const match = orderedlistRegex.exec(content);
        if (match) {
            const token = { id: v4(), type: "OrderedList", raw: "", tokens: [] } as IMarkdownOrderedListToken;
            while (content) {
                const match = orderedlistRegex.exec(content);
                if (match) {
                    const raw = match[0];
                    token.raw += raw;
                    token.tokens.push(match[2]);
                    content = content.substring(raw.length);
                } else {
                    break;
                }
            }
            return token;
        } else {
            return null;
        }
    }

    private generateCheckList(text: string) : IMarkdownCheckListToken | null {
        let content = text;
        const match = checkListRegex.exec(content);
        if (match) {
            const token = { id: v4(), type: "Checklist", raw: "", tokens: [] } as IMarkdownCheckListToken;
            while (content) {
                const match = checkListRegex.exec(content);
                if (match) {
                    const raw = match[0];
                    token.raw += raw;
                    token.tokens.push({ token: match[3], isChecked: (match[2] === "x" || match[2] === "X")} as IMarkdownCheckListItemToken);
                    content = content.substring(raw.length);
                } else {
                    break;
                }
            }
            return token;
        } else {
            return null;
        }
    }

    private generateTable(text: string): IMarkdownTableToken | null {
        const match = tableRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Table", raw: match[0], headers: [], cells: [] } as IMarkdownTableToken;
            token.headers = this.decodeTableHeaders(match[1]);
            token.cells = this.decodeTableCells(match[3]);
            return token;
        } else {
            return null;
        }
    }

    private decodeTableHeaders(cellText: string) {
        return cellText.trim().split("|").map(c => c.trim()).filter(c => c.length > 0)
    }

    private decodeTableCells(cellText: string) {
        return cellText.trim().split("\n").map(l => {
            return this.decodeTableHeaders(l);
        });
    }

    private generateParagraph(text: string): IMarkdownParagraph | null {
        const match = paragraphRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Paragraph", raw: match[0], tokens: [] } as IMarkdownParagraph;
            token.tokens = this.parseInline(match[1].trimEnd());
            return token;
        } else {
            return null;
        }
    }

    private generateBlockquote(text: string): IMarkdownBlockQuote | null {
        const match = blockQuoteRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Blockquote", raw: match[0], text: match[2] } as IMarkdownBlockQuote;
            return token;
        } else {
            return null;
        }
    }

    private generateLink(text: string): IMarkdownLink | null {
        const match = linkRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Link", raw: match[0], title: match[1], link: match[2] } as IMarkdownLink;
            return token;
        } else {
            return null;
        }
    }

    private generateBold(text: string): IMarkdownBold | null {
        const match = boldRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Bold", raw: match[0], tokens: []} as IMarkdownBold;
            token.tokens = this.parseInline(match[1])
            return token;
        } else {
            return null;
        }
    }

    private generateItalic(text: string): IMarkdownItalic | null {
        const match = italicRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Italic", raw: match[0], tokens: []} as IMarkdownItalic;
            token.tokens = this.parseInline(match[1])
            return token;
        } else {
            return null;
        }
    }

    private generateStrikeThrough(text: string): IMarkdownStrikeThrough | null {
        const match = strikeThroughRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "StrikeThrough", raw: match[0], tokens: []} as IMarkdownStrikeThrough;
            token.tokens = this.parseInline(match[2])
            return token;
        } else {
            return null;
        }
    }

    private generateText(text: string): IMarkdownInlineText | null {
        const match = inlineTextRegex.exec(text);
        if (match) {
            const token = { id: v4(), type: "Text", raw: match[0], text: match[0] } as IMarkdownInlineText;
            return token;
        } else {
            return null;
        }
    }

    private generateMermaid(text: string): IMarkdownMermaid | null {
        const match = mermaidDiagram.exec(text);
        if (match) {
            const token = { id: v4(), type: "Mermaid", raw: match[0] } as IMarkdownMermaid;
            token.graph = this._mermaidLexer.parse(match[1]);
            return token;
        } else {
            return null;
        }
    }
}


export interface IMarkdownToken {
    id: string;
    type: MarkdownTokenType;
    raw: string;
}
export interface IMarkdownSpaceToken extends IMarkdownToken {

}
export interface IMarkdownHeadingToken extends IMarkdownToken {
    level: number;
    tokens: string;
}

export interface IMarkdownUnorderedListToken extends IMarkdownToken {
    tokens: string[];
}

export interface IMarkdownOrderedListToken extends IMarkdownToken {
    tokens: string[];
}

export interface IMarkdownCheckListToken extends IMarkdownToken {
    tokens: IMarkdownCheckListItemToken[];
}
export interface IMarkdownCheckListItemToken {
    token: string;
    isChecked: boolean;
}

export interface IMarkdownFenceToken extends IMarkdownToken {
    code: string;
}

export interface IMarkdownTableToken extends IMarkdownToken {
    headers: string[];
    cells: string[][];
}

export interface IMarkdownParagraph extends IMarkdownToken {
    tokens: IMarkdownToken[];
}

export interface IMarkdownBlockQuote extends IMarkdownToken {
    text: string;
}

export interface IMarkdownLink extends IMarkdownToken {
    title: string;
    link: string;
}

export interface IMarkdownBold extends IMarkdownToken {
    tokens: IMarkdownToken[];
}

export interface IMarkdownItalic extends IMarkdownToken {
    tokens: IMarkdownToken[];
}

export interface IMarkdownStrikeThrough extends IMarkdownToken {
    tokens: IMarkdownToken[];
}

export interface IMarkdownInlineText extends IMarkdownToken {
    text: string;
}

export interface IMarkdownMermaid extends IMarkdownToken {
    graph: IMermaidGraph | null;
}





export type MarkdownTokenType = "Space" | "Heading" | "UnorderedList" | "OrderedList" | "Fence" | "Table" | "Checklist" | "Paragraph" | "Blockquote" |
 "Link" | "Bold" | "Italic" | "StrikeThrough" | "Text" | "Mermaid";

const newlineRegex = /^(?:[ \t]*(?:\n|$))+/;
const headingRegex = /^ {0,3}(#{1,6})(?=\s|$)(.*)(?:\n+|$)/;
const orderedlistRegex = /^( {0,3}(?:\d{1,9}[.)]))([ \t][^\n]+?)?(?:\n|$)/;
const unorderedlistRegex = /^( {0,3}(?:[*+-]))([ \t][^\n]+?)?(?:\n|$)/;
const fenceRegex = /^ {0,3}(`{3,}(?=[^`\n]*(?:\n|$))|~{3,})([^\n]*)(?:\n|$)(?:|([\s\S]*?)(?:\n|$))(?: {0,3}\1[~`]* *(?=\n|$)|$)/;
const checkListRegex = /^( {0,3}(?:[*+-]))[ \t]\[(x|X| )\]([^\n]+?)?(?:\n|$)/;
//const paragraphRegex = /^([^\n]+(?:\n[^\n]+)*)/;
const paragraphRegex = /^([^\n]+(?:\n)*)/;
const blockQuoteRegex = /^( {0,3}> ?([^\n]*)(?:\n|$))+/;
const tableRegex = /^ *([^\\n ].*)\n {0,3}((?:\| *)?:?-+:? *(?:\| *:?-+:? *)*(?:\| *)?)(?:\n((?:(?! *\n).*(?:\n|$))*)\n*|$)/;
const linkRegex = /^\[([^\n]+)\]\(([a-zA-Z][a-zA-Z0-9+.-]{1,31}:\/\/[^\s\x00-\x1f<>]*)\)/;
const inlineTextRegex = /^(`+|[^`])(?:(?= {2,}\n)|[\s\S]*?(?:(?=[\\<!\[`*_]|\b_|$)|[^ ](?= {2,}\n)))/;
const boldRegex = /^[(\*|]{2}([^\n]+)[(\*|]{2}/;
const italicRegex = /^[(\*|]([^\n]+)[(\*|]/;
const strikeThroughRegex = /^(~~?)(?=[^\s~])([\s\S]*?[^\s~])\1(?=[^~]|$)/;
const mermaidDiagram = /\`\`\`{mermaid}\n((?:(.*)\n)*)\`\`\`/;
