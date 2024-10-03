import { IDocument } from "../../../common/document.ts";
import { EventManager } from "../../business/eventManager.ts";

export interface IMarkdownEditorProps {
    document: IDocument,
    content: string,
    setContent: React.Dispatch<React.SetStateAction<string>>,
    eventManager: EventManager
}

export function MarkdownEditor(props: IMarkdownEditorProps) {
    const { document, content, setContent, eventManager } = props;
    return (
        <>
            <textarea value={content} onChange={(e) => { setContent(e.target.value); }} onBlur={() => {
                eventManager.updateFile(document.id, document.path, content)
            }}/>
        </>
    )
}