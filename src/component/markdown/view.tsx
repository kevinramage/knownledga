import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import { MarkdownRendererView } from "./renderer.tsx";
import { IDocument } from "../../../common/document.ts";
import { MarkdownEditor } from "./editor.tsx";
import { EventManager } from "../../business/eventManager.ts";
import { useEffect, useState } from "react";

export interface IMarkdownViewProps {
    document: IDocument,
    eventManager: EventManager
}

export function MarkdownView(props: IMarkdownViewProps) {
    const { document, eventManager } = props;
    const [ content, setContent ] = useState(document.content);
    useEffect(() => {
        setContent(document.content);
    }, [ document ]);

    return (
        <PanelGroup direction="horizontal">
            <Panel className="panel">
                <MarkdownEditor document={document} content={content} setContent={setContent} eventManager={eventManager} />
            </Panel>
            <PanelResizeHandle className='panelResize' />
            <Panel className="panel">
                <MarkdownRendererView content={content} />
            </Panel>
        </PanelGroup>
    )
}