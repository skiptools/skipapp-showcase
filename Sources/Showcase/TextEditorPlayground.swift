// Copyright 2023–2025 Skip
import SwiftUI

struct TextEditorPlayground: View {
    @State var text = """
    When in the course of human events, it becomes necessary for an Oppressed People to Rise, and assert their Natural Rights, as Human Beings, as Native & mutual Citizens of a free Republic, and break that odious Yoke of oppression, which is so unjustly laid upon them by their fellow Countrymen, and to assume among the powers of Earth the same equal privileges to which the Laws of Nature, & natures God entitle them; A moderate respect for the opinions of Mankind, requires that they should declare the causes which incite them to this just & worthy action.

    We hold these truths to be Self Evident; That All Men are Created Equal; That they are endowed by their Creator with certain unalienable rights. That among these are Life, Liberty; & the persuit of happiness. That Nature hath freely given to all Men, a full Supply of Air. Water, & Land; for their sustinance, & mutual happiness, That No Man has any right to deprive his fellow Man, of these Inherent rights, except in punishment of Crime. That to secure these rights governments are instituted among Men, deriving their just powers from the consent of the governed. That when any form of Government, becomes destructive to these ends, It is the right of the People, to alter, Amend, or Remoddel it, Laying its foundation on Such Principles, & organizing its powers in such form as to them shall seem most likely to effect the safety, & happiness of the Human Race.
    """

    var body: some View {
        TextEditor(text: $text)
            .italic()
        .toolbar {
            PlaygroundSourceLink(file: "TextEditorPlayground.swift")
        }
    }
}
