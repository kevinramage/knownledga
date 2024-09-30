import { IDocument } from "../../../common/document.ts";

export interface IMarkdownEditorProps {
    document: IDocument
}

export function MarkdownEditor(props: IMarkdownEditorProps) {
    const { document } = props;
    return (
        <>
            <textarea value={document.content} readOnly/>
        </>
    )
}