import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import { MarkdownRendererView } from "./renderer.tsx";
import { IDocument } from "../../../common/document.ts";
import { MarkdownEditor } from "./editor.tsx";
import { EventManager } from "../../business/eventManager.ts";
import { useEffect, useState } from "react";
import { ToggleButton, ToggleButtonGroup, Toolbar } from "@mui/material";
import { RawEditor } from "./rawEditor.tsx";

export interface IMarkdownViewProps {
    document: IDocument,
    eventManager: EventManager
}

export function MarkdownView(props: IMarkdownViewProps) {
    const { document, eventManager } = props;
    const [ content, setContent ] = useState(document.content);
    const [ values, setValues ] = useState(["EDITOR", "RENDERER"]);
    const isEditorDisplay = values.includes("EDITOR");
    const isRawViewDisplay = values.includes("RAW");
    const isRendererDisplay = values.includes("RENDERER");

    useEffect(() => { setContent(document.content); }, [ document ]);

    return (
        <>
        <Toolbar className="toolbar">
            <ToggleButtonGroup value={values} onChange={(_, vals) => { setValues(vals)}}>
                <ToggleButton value="EDITOR">Editor</ToggleButton>
                <ToggleButton value="RAW">Raw</ToggleButton>
                <ToggleButton value="RENDERER">Renderer</ToggleButton>
            </ToggleButtonGroup>
        </Toolbar>
        <PanelGroup direction="horizontal">
            { isEditorDisplay && (
            <>
            <Panel className="panel panelWithoutFlex">
                <MarkdownEditor doc={document} content={content} setContent={setContent} eventManager={eventManager} />
            </Panel>
            <PanelResizeHandle className='panelResize' />
            </>
            )}
            { isRawViewDisplay && (
            <>
            <Panel className="panel">
                <RawEditor document={document} content={content} setContent={setContent} eventManager={eventManager} />
            </Panel>
            <PanelResizeHandle className='panelResize' />
            </>
            )}
            { isRendererDisplay && (
            <Panel className="panel">
                <MarkdownRendererView content={content} eventManager={eventManager} />
            </Panel>
            )}
        </PanelGroup>
        </>
    )
}