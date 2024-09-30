export interface IOptions {
    panels: {
        top: IPanel,
        bottom: IPanel,
        left: IPanel,
        right: IPanel,
    }
}

export interface IPanel {
    disable: boolean,
    size?: number
}

export const DEFAULT_OPTIONS : IOptions = {
    panels: {
        top: { disable: true, size: 10 },
        bottom : { disable: true, size: 10 },
        left: { disable: false, size: 20},
        right: { disable: true, size: 5}
    }
}