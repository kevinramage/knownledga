import { EventManager } from "../../business/eventManager.ts";
import { IMarkdownBlockQuote, IMarkdownCheckListToken, IMarkdownBold, IMarkdownFenceToken, IMarkdownHeadingToken, IMarkdownInlineText, IMarkdownLink, IMarkdownOrderedListToken, IMarkdownParagraph, IMarkdownSpaceToken, IMarkdownTableToken, IMarkdownToken, IMarkdownUnorderedListToken, MarkdownLexer, IMarkdownItalic, IMarkdownMermaid, IMarkdownStrikeThrough, IMarkdownBrToken, IMarkdownContainer } from "./lexer.ts"
import { IFlowChartNode, IMermaidFlowChart } from "./mermaidLexer.ts";

/*

Don't put tabs or spaces in front of your paragraphs.
*/

export interface IMarkdownRendererViewProps {
    eventManager: EventManager
    content: string
}

export function MarkdownRendererView(props: IMarkdownRendererViewProps) {
    const { eventManager, content } = props;
    const tokens = new MarkdownLexer().parse(content);

    return (
        <div className="md_document">
        { tokens.map(t => renderBlock(t, eventManager))}
        </div>
    )
}

function renderBlock(block: IMarkdownToken, eventManager: EventManager) {
    if (block.type === "Heading") {
        return renderTitle(block as IMarkdownHeadingToken, eventManager);
    } else if (block.type === "Space") {
        return renderSpace(block as IMarkdownSpaceToken);
    } else if (block.type === "Fence") {
        return renderFence(block as IMarkdownFenceToken);
    } else if (block.type === "UnorderedList") {
        return renderUnorderedList(block as IMarkdownUnorderedListToken, eventManager);
    } else if (block.type === "OrderedList") {
        return renderOrderedList(block as IMarkdownOrderedListToken, eventManager);
    } else if (block.type === "Table") {
        return renderTable(block as IMarkdownTableToken);
    } else if (block.type === "Checklist") {
        return renderCheckList(block as IMarkdownCheckListToken);
    } else if (block.type === "Paragraph") {
        return renderParagraph(block as IMarkdownParagraph, eventManager);
    } else if (block.type === "Blockquote") {
        return renderBlockQuote(block as IMarkdownBlockQuote, eventManager);
    } else if (block.type === "Mermaid") {
        return renderMermaidGraph(block as IMarkdownMermaid);
    } else {
        console.error("Invalid block: ", block);
        return (<></>)
    }
}

function renderInline(inlineTokens: IMarkdownToken[], eventManager: EventManager) {
    return (
        <>
        { inlineTokens.map(t => {
            if (!t) {
                console.error("renderInline - Invalid inline token", t);
            } else if (t.type === "Link") {
                return renderLink(t as IMarkdownLink, eventManager);
            } else if (t.type === "Bold") {
                return renderBold(t as IMarkdownBold, eventManager);
            } else if (t.type === "Italic") {
                return renderItalic(t as IMarkdownItalic, eventManager);
            } else if (t.type === "StrikeThrough") {
                return renderStrikeThrough(t as IMarkdownStrikeThrough, eventManager);
            } else if (t.type === "Br") {
                return renderBr(t as IMarkdownBrToken);
            } else if (t.type === "OrderedList") {
                return renderOrderedList(t as IMarkdownOrderedListToken, eventManager);
            } else if (t.type === "UnorderedList") {
                return renderUnorderedList(t as IMarkdownUnorderedListToken, eventManager);
            } else if (t.type === "Container") {
                return renderContainer(t as IMarkdownContainer, eventManager);
            } else if (t.type === "Text") {
                return renderText(t as IMarkdownInlineText);
            } else {
                console.error("Invalid inline token: ", t);
            }
        })}
        </>
    )
}

function renderTitle(block: IMarkdownHeadingToken, eventManager: EventManager) {
    if (block.level === 1) {
        return (<h1 key={block.id}>{renderInline(block.tokens, eventManager)}</h1>)
    } else if (block.level === 2) {
        return (<h2 key={block.id}>{renderInline(block.tokens, eventManager)}</h2>)
    } else if (block.level === 3) {
        return (<h3 key={block.id}>{renderInline(block.tokens, eventManager)}</h3>)
    } else if (block.level === 4) {
        return (<h4 key={block.id}>{renderInline(block.tokens, eventManager)}</h4>)
    } else if (block.level === 5) {
        return (<h5 key={block.id}>{renderInline(block.tokens, eventManager)}</h5>)
    } else if (block.level === 6) {
        return (<h6 key={block.id}>{renderInline(block.tokens, eventManager)}</h6>)
    } else {
        console.error("Invalid title block: ", block);
        return (<></>)
    }
}

function renderFence(block: IMarkdownFenceToken) {
    return (
        <pre key={block.id}>
            <code>{block.code}</code>
        </pre>
    )
}

function renderUnorderedList(block: IMarkdownUnorderedListToken, eventManager: EventManager) {
    return (
        <ul key={block.id}>
            { block.tokens.map((t, i) => {
                const className = (t.type === "UnorderedList") ? "md_li_withoutdisk" : "md_li";
                return (<li key={i} className={className}>{renderInline([t], eventManager)}</li>)             
            })}
        </ul>
    )
}

function renderOrderedList(block: IMarkdownOrderedListToken, eventManager: EventManager) {
    return (
        <ol key={block.id}>
            { block.tokens.map((t, i) => {
                const className = (t.type === "OrderedList") ? "md_li_withoutdisk" : "md_li";
                return (<li key={i} className={className}>{renderInline([t], eventManager)}</li>)             
            })}
        </ol>
    )
}

function renderCheckList(block: IMarkdownCheckListToken) {
    return (
        <ul key={block.id} className="md_checklist">
            { block.tokens.map((t, i) => { return (
                <li key={i}><input type="checkbox" checked={t.isChecked} readOnly /><span>{t.token}</span></li>)}
            )}
        </ul>
    )
}


function renderSpace(block: IMarkdownSpaceToken) {
    return (<br key={block.id}/>)
}

function renderTable(block: IMarkdownTableToken) {
    return (
        <table key={block.id} className="md_table">
            <thead>
                <tr>
                    { block.headers.map((h,i) => { return (<td key={i} className="md_tablecell">{h}</td>)})}
                </tr>
            </thead>
            <tbody>
                { block.cells.map((l, i) => {
                    return (
                        <tr key={i}>
                            { l.map((c,i) => { return (<td key={i} className="md_tablecell">{c}</td>) })}
                        </tr>
                    )
                })}
            </tbody>
        </table>
    )
}

function renderParagraph(block: IMarkdownParagraph, eventManager: EventManager) {
    return ( <p className="md_paragraph" key={block.id}>{renderInline(block.tokens, eventManager)}</p> )
}

function renderBlockQuote(block: IMarkdownBlockQuote, eventManager: EventManager) {
    return ( <blockquote key={block.id} className="md_blockquote"><p>{renderInline(block.tokens, eventManager)}</p></blockquote> )
}

function renderLink(inline: IMarkdownLink, eventManager: EventManager) {
    let onclick = () => {
        window.open(inline.link, '_blank');
    }
    if (inline.internal) {
        onclick = () => {
            eventManager.openDomentFromPath(inline.link);
        }
    }
    return <a key={inline.id} href="#" title={inline.title} onClick={onclick}>{inline.title}</a>
}

function renderBold(inline: IMarkdownBold, eventManager: EventManager) {
    return <strong key={inline.id}>{renderInline(inline.tokens, eventManager)}</strong>
}

function renderItalic(inline: IMarkdownBold, eventManager: EventManager) {
    return <em key={inline.id}>{renderInline(inline.tokens, eventManager)}</em>
}

function renderStrikeThrough(inline: IMarkdownStrikeThrough, eventManager: EventManager) {
    return <del key={inline.id}>{renderInline(inline.tokens, eventManager)}</del>
}

function renderBr(inline: IMarkdownBrToken) {
    return <br key={inline.id} />
}

function renderContainer(container: IMarkdownContainer, eventManager: EventManager) {
    return (<span key={container.id}>{renderInline(container.tokens, eventManager)}</span>)
}

function renderText(inline: IMarkdownInlineText) {
    return <span key={inline.id}>{inline.text}</span>
}

function renderMermaidGraph(mermaid: IMarkdownMermaid) {
    if (mermaid.graph && mermaid.graph.type === "FlowChart") {
        return renderFlowChartGraph(mermaid.graph as IMermaidFlowChart);
    } else if (mermaid.graph) {
        console.error("Invalid mermaid graph type", mermaid.graph.type);
        return <></>
    } else {
        console.error("Invalid mermaid graph");
        return <></>
    }
}

function renderFlowChartGraph(graph: IMermaidFlowChart) {
    return (
        <svg key={graph.id} width={graph.width}>
            { graph.nodes.map(n => renderFlowChartNode(n) ) }
        </svg>
    )
}

function renderFlowChartNode(node: IFlowChartNode) {
    if (node.nodeType === "SQUARE") {
        return renderFlowChartSquareNode(node);
    } else if (node.nodeType === "ROUND_EDGE") {
        return renderFlowChartRoundEdge(node);
    } else {
        console.error("Inavlid flowChart node type: " + node.nodeType);
        return <></>
    }
}

function renderFlowChartSquareNode(node: IFlowChartNode) {
    return (
        <g key={node.id}>
            <rect key={node.id} x={node.positionX} y={node.positionY} width={node.width} height={50} fill="#2780e31a" stroke="#343a40"></rect>
            <text x={node.textPositionX} y={node.textPositionY} width={node.textWidth} height={50} fill="white">{node.title}</text>
        </g>
    )
}

function renderFlowChartRoundEdge(node: IFlowChartNode) {
    return (
        <g key={node.id}>
            <rect key={node.id} x={node.positionX} y={node.positionY} width={node.width} height={50} rx={5} ry={5} fill="#2780e31a" stroke="#343a40"></rect>
            <text x={node.textPositionX} y={node.textPositionY} width={node.textWidth} height={50} fill="white">{node.title}</text>
        </g>
    )
}

function renderFlowChartStadiumShaped(node: IFlowChartNode) {
    return (
        <g key={node.id}>
            <rect key={node.id} x={node.positionX} y={node.positionY} width={node.width} height={50} rx={20} ry={20} fill="#2780e31a" stroke="#343a40"></rect>
            <text x={node.textPositionX} y={node.textPositionY} width={node.textWidth} height={50} fill="white">{node.title}</text>
        </g>
    )
}

