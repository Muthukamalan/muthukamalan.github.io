# Personal Blog

checkout: https://muthukamalan.github.io


Credits:
- Powered by zola
- Tabi Theme



{% mermaid(invertible=true, full_width=false) %}
flowchart LR
    A[Start] --> B{Choose Option}
    B -->|Yes| C[Process Action]
    B -->|No| D[End]
    C --> D
{% end %}

{% mermaid() %}
classDiagram
    class CognitiveDistortions {
        +AllOrNothingThinking()
        +Overgeneralization()
        +MentalFilter()
        +JumpingToConclusions()
    }
    class AllOrNothingThinking {
        +SeeInExtremes()
    }
    class Overgeneralization {
        +GeneralizeFromSingle()
    }
    class MentalFilter {
        +FocusOnNegative()
    }
    class JumpingToConclusions {
        +MakeAssumptions()
    }
    CognitiveDistortions *-- AllOrNothingThinking
    CognitiveDistortions *-- Overgeneralization
    CognitiveDistortions *-- MentalFilter
    CognitiveDistortions *-- JumpingToConclusions
{% end %}
