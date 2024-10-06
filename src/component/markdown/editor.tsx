import { Button, IconButton, LinearProgress, ToggleButton, ToggleButtonGroup, Toolbar } from "@mui/material";
import { IDocument } from "../../../common/document.ts";
import { EventManager } from "../../business/eventManager.ts";
import TitleIcon from '@mui/icons-material/Title';
import FormatListNumberedIcon from '@mui/icons-material/FormatListNumbered';
import FormatListBulletedIcon from '@mui/icons-material/FormatListBulleted';
import ChecklistIcon from '@mui/icons-material/Checklist';
import { ChangeEvent, ChangeEventHandler, KeyboardEvent, useRef, useState } from "react";
import { IEditorBlock, MarkdownEditorBlock } from "./editorBlock.tsx";

export interface IMarkdownEditorProps {
    doc: IDocument,
    content: string,
    setContent: React.Dispatch<React.SetStateAction<string>>,
    eventManager: EventManager
}

export function MarkdownEditor(props: IMarkdownEditorProps) {
    const { doc, content, setContent, eventManager } = props;
    const [ lineNumber, setLineNumber ] = useState(1);
    const [ blocks, setBlocks ] = useState([] as IEditorBlock []);
    const [ currentBlock, setCurrentBlock ] = useState(null as IEditorBlock | null);

    /*
    const manageKeyEvtCurrentBlock = (e: ChangeEvent<HTMLTextAreaElement>) => {
        const currentBlock = {lineNumber: -1, type: "TEXT", text: e.currentTarget.value} as ITextEditorBlock;
        setCurrentBlock(currentBlock);
        saveContent(blocks, currentBlock);
    }
    */
    /*
    const manageNewLine = (e: KeyboardEvent<HTMLTextAreaElement>) => {
        e.stopPropagation();
        if (e.code === "Enter") {
            const textBlock = currentBlock as ITextEditorBlock;
            textBlock.text = textBlock.text.substring(0, textBlock.text.length - 1); // Remove \n character
            textBlock.lineNumber = lineNumber; // Assign the new line number
            const newBlocks = [...blocks, textBlock];
            setBlocks(newBlocks);
            setLineNumber(lineNumber+1);
            setCurrentBlock(null);
            saveContent(newBlocks, null);
        }
        //return false;
    }
    */
    /*
    const updateLine = (content: string, lineNumber: number) => {

        // Update blocks
        const newBlocks = blocks.map(b => {
            if (b.lineNumber === lineNumber) { return {...b, text: content } as ITextEditorBlock }
            else { return b; }
        });
        setBlocks(newBlocks);
        saveContent(newBlocks, currentBlock);
    }
    */
    /*
    const saveContent = (blocks: IEditorBlock[], currentBlock: IEditorBlock|null) => {
        const blocksToRender = blocks.concat([]);
        if (currentBlock) { blocksToRender.push(currentBlock); }
        console.info(blocksToRender);
        const text = generateMarkdownFromBlocks(blocksToRender);
        setContent(text);
    }
    */
    //const newLine = currentBlock ? (currentBlock as ITextEditorBlock).text : "";

    return (
        <>
            <Toolbar className="toolbar">
                <Button title="Heading"><TitleIcon /></Button>
                <Button title="Non ordered list"><FormatListNumberedIcon /></Button>
                <Button title="Ordered list"><FormatListBulletedIcon /></Button>
                <Button title="Checkbox"><ChecklistIcon /></Button>
            </Toolbar>
            <pre className="markdownEditor">
                { blocks.map(b => <MarkdownEditorBlock block={b} />)}
                { /*<textarea contentEditable={true} suppressContentEditableWarning={true} value={newLine} onKeyUp={manageNewLine} onChange={manageKeyEvtCurrentBlock}></textarea>*/ }
            </pre>
        </>
    )
}

type UpdateLineHandler = (content: string, lineNumber: number) => void;




/*
function generateMarkdownFromBlocks(blocks: IEditorBlock[]) {
    return blocks.map(b => generateMarkdownFromBlock(b)).join("\n");
}

function generateMarkdownFromBlock(block: IEditorBlock) {
    if (block.type === "TEXT") {
        return generateMarkdownFromTextBlock(block as ITextEditorBlock);
    } else {
        console.error("Invalid type: " + block.type);
    }
}

function generateMarkdownFromTextBlock(block: ITextEditorBlock) {
    return block.text;
}
*/