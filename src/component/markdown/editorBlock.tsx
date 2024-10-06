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

function renderTitle() {

}

function renderUnorderedList() {

}

function renderOrderedList() {

}