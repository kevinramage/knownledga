import { ChangeEvent, Dispatch, FocusEvent, KeyboardEvent, SetStateAction } from "react";
import { IDocument } from "../../../common/document.ts";
import { EventManager } from "../../business/eventManager.ts";

export interface IRawEditorProps {
    document: IDocument,
    content: string,
    setContent: React.Dispatch<React.SetStateAction<string>>,
    eventManager: EventManager
}

export function RawEditor(props: IRawEditorProps) {
    const { document, content, setContent, eventManager } = props;

    const onChangeFunc = (e: ChangeEvent<HTMLTextAreaElement>) => { onChange(e, setContent); }
    const onKeyUpFunc = (e: KeyboardEvent<HTMLTextAreaElement>) => { onKeyUp(e, setContent); }
    const onBlurFunc = (e: FocusEvent<HTMLTextAreaElement, Element>) => { onBlur(e, eventManager, document); }
    
    return (
        <>
            <textarea value={content} onKeyUp={onKeyUpFunc} onChange={onChangeFunc} onBlur={onBlurFunc}/>
        </>
    )
}

function onChange(e: ChangeEvent<HTMLTextAreaElement>, setContent: Dispatch<SetStateAction<string>>) {
    setContent(e.target.value);
}
function onKeyUp(e: KeyboardEvent<HTMLTextAreaElement>, setContent: Dispatch<SetStateAction<string>>) {
    setContent(e.currentTarget.value);
}
function onBlur(e: FocusEvent<HTMLTextAreaElement, Element>, eventManager: EventManager, document: IDocument) {
    eventManager.updateFile(document.id, document.path, e.currentTarget.value);
}