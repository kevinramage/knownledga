import { v4 } from "uuid";
import { IMarkdownHeadingToken, IMarkdownInlineText, IMarkdownParagraph, IMarkdownToken, MarkdownLexer } from "./lexer";

export type EDITOR_BLOCK_TYPE = "TEXT" | "TITLE" | "UNORDEREDLIST" | "ORDEREDLIST" | "CHECKBOX";
export interface IEditorBlock {
    type: EDITOR_BLOCK_TYPE;
    lineNumber: number;
}
export interface ITextEditorBlock extends IEditorBlock {
    text: string;
}

export interface IMarkdownEditorProps {
    block: IEditorBlock;
}

export function MarkdownEditorBlock(props : IMarkdownEditorProps) {
    const { block } = props;
    return renderBlock(block);
}

function renderBlock(block: IEditorBlock) {
    if (block.type === "TEXT") { return renderText(block as ITextEditorBlock); }
    if (block.type === "TITLE") { return renderTitle(block as ITextEditorBlock); }
    else {
        console.error("MarkdownEditor - renderLine - Invalid block: " + block.type);
        return <></>
    }
}

function renderText(block: ITextEditorBlock) {
    return (
        <span key={block.lineNumber} className="line" contentEditable={true} suppressContentEditableWarning={true}>
            {block.text}
        </span>
    )
}

function renderTitle(block: ITextEditorBlock) {
    return (
        <span key={block.lineNumber} className="line" contentEditable={true} suppressContentEditableWarning={true}>
            {block.text}
        </span>
    )
}

function renderUnorderedList() {

}

function renderOrderedList() {

}

export function getBlocksFromContent(content: string) {
    const tokens = new MarkdownLexer().parse(content);
    const blocks = tokens.map(t => getBlockFromToken(t)).filter(t => t !== null);
    let lineNumber = 1;
    blocks.forEach(b => b.lineNumber = lineNumber++);
    return blocks;
}
function getBlockFromToken(token: IMarkdownToken) {
    if (token.type === "Paragraph") {
        return getBlockFromParagraph(token as IMarkdownParagraph);
    } else if (token.type === "Heading") {
        return getBlockFromHeading(token as IMarkdownHeadingToken);
    } else {
        console.error("getBlockFromToken - Unknown type: " + token.type);
        return null;
    }
}
function getBlockFromParagraph(token: IMarkdownParagraph) {
    if (token.tokens && token.tokens.length === 1 && token.tokens[0].type === "Text") {
        const text = (token.tokens[0] as IMarkdownInlineText).text;
        return { id: v4(), type: "TEXT", text: text, lineNumber: 0 } as ITextEditorBlock;
    } else {
        console.error("getBlockFromParagraph - Unknown token: ", token);
        return null;
    }
}
function getBlockFromHeading(token: IMarkdownHeadingToken) {
    return { id: v4(), type: "TITLE", text: token.tokens, lineNumber: 0 } as ITextEditorBlock;
}