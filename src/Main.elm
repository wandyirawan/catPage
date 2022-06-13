module Main exposing (..)

import Browser
import Element
    exposing
        ( Element
        , alignRight
        , centerX
        , column
        , image
        , maximum
        , mouseOver
        , padding
        , paddingEach
        , paddingXY
        , paragraph
        , rgb255
        , width
        )
import Element.Background as EBG
import Element.Border as EB
import Element.Font as EF
import Element.Input as EI
import Element.Region as ER
import Html exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = darkColors
        , view = viewLayout
        , update = update
        }


type Msg
    = MsgChangeColors


update : Msg -> Model -> Model
update _ model =
    if model.primary == darkColors.primary then
        lightColors

    else
        darkColors


darkColors : Model
darkColors =
    { primary = rgb255 0xFF 0xAB 0x00
    , primaryLight = rgb255 0xFF 0xDD 0x4B
    , primaryDark = rgb255 0xC6 0x7C 0x00
    , secondary = rgb255 0x3E 0x27 0x23
    , secondaryLight = rgb255 0x6A 0x4F 0x4B
    , secondaryDark = rgb255 0x1B 0x00 0x00
    , textOnPrimary = rgb255 0x00 0x00 0x00
    , textOnSecondary = rgb255 0xFF 0xFF 0xFF
    }


lightColors : Model
lightColors =
    { secondary = rgb255 0xFF 0xAB 0x00
    , secondaryLight = rgb255 0xFF 0xDD 0x4B
    , secondaryDark = rgb255 0xC6 0x7C 0x00
    , primary = rgb255 0x3E 0x27 0x23
    , primaryLight = rgb255 0x6A 0x4F 0x4B
    , primaryDark = rgb255 0x1B 0x00 0x00
    , textOnSecondary = rgb255 0x00 0x00 0x00
    , textOnPrimary = rgb255 0xFF 0xFF 0xFF
    }


fontGreatVibes : Element.Attribute msg
fontGreatVibes =
    EF.family [ EF.typeface "GreatVibes" ]


fontTypewriter : Element.Attribute msg
fontTypewriter =
    EF.family [ EF.typeface "Typewriter" ]


type alias Model =
    { primaryDark : Element.Color
    , secondaryDark : Element.Color
    , textOnSecondary : Element.Color
    , primaryLight : Element.Color
    , primary : Element.Color
    , textOnPrimary : Element.Color
    , secondary : Element.Color
    , secondaryLight : Element.Color
    }


viewLayout : Model -> Html Msg
viewLayout model =
    Element.layoutWith
        { options =
            [ Element.focusStyle
                { backgroundColor = Nothing
                , borderColor = Just model.primaryDark
                , shadow = Nothing
                }
            ]
        }
        [ EBG.color model.secondaryDark
        , padding 22
        , EF.color model.textOnSecondary
        ]
        (Element.column []
            [ buttonChangeColors model
            , viewTitle model
            , viewSubtitle model
            , catImage
            , viewContent
            ]
        )


viewTitle : Model -> Element msg
viewTitle model =
    Element.paragraph
        [ EF.bold
        , EF.color model.primary
        , fontGreatVibes
        , EF.size 52
        , ER.heading 1
        ]
        [ Element.text "My Cat"
        ]


viewSubtitle : Model -> Element msg
viewSubtitle model =
    Element.paragraph
        [ EF.color model.primaryLight
        , EF.size 18
        , fontTypewriter
        , paddingXY 0 10
        , ER.heading 2
        ]
        [ Element.text "A web page for my cat"
        ]


catImage : Element msg
catImage =
    image
        [ width (maximum 400 Element.fill)
        , centerX
        ]
        { src = "cat.png"
        , description = "A picture of a cat"
        }


buttonChangeColors : Model -> Element Msg
buttonChangeColors model =
    EI.button
        [ EBG.color model.primaryLight
        , EB.rounded 8
        , EF.color model.secondaryDark
        , alignRight
        , paddingEach { top = 8, right = 8, bottom = 5, left = 8 }
        , EF.size 14
        , EF.bold
        , mouseOver
            [ EBG.color model.primary
            ]
        ]
        { onPress = Just MsgChangeColors
        , label = Element.text "Change Color"
        }


text1 : String
text1 =
    "Pudding cotton candy tart halvah tootsie roll ice cream cheesecake. Cookie shortbread cookie pastry shortbread fruitcake muffin pudding. Lollipop dessert dessert cake bonbon jelly-o tootsie roll dessert. Sweet jujubes shortbread candy tiramisu tiramisu shortbread dessert. Oat cake fruitcake dragée shortbread tiramisu cheesecake. Caramels halvah toffee cotton candy chocolate bar macaroon biscuit. Tootsie roll topping cheesecake powder donut. Oat cake soufflé sweet roll macaroon shortbread jelly-o chocolate bar pudding croissant. Tootsie roll lollipop jelly-o liquorice fruitcake gummies jelly beans."


text2 : String
text2 =
    "Oat cake wafer cookie marshmallow candy cookie dessert wafer. Jujubes halvah bear claw gummies halvah gummies cookie. Liquorice pie toffee ice cream topping muffin jelly. Brownie brownie chocolate bar lemon drops jujubes chocolate bar chocolate bar tiramisu cookie. Candy canes ice cream icing sugar plum cake candy canes. Marzipan shortbread bonbon bear claw candy canes sesame snaps donut."


text3 : String
text3 =
    "Candy canes oat cake ice cream gingerbread gummi bears tart topping. Pie powder cake marzipan apple pie sesame snaps muffin liquorice powder. Jelly-o sweet oat cake jelly chocolate bear claw topping. Lollipop cookie jujubes apple pie bear claw danish croissant caramels. Gingerbread tootsie roll candy gummies lemon drops chocolate bar sweet cheesecake jelly. Liquorice tiramisu cake biscuit bonbon."


paddingTop : Int -> Element.Attribute msg
paddingTop size =
    paddingEach { top = size, right = 0, bottom = 0, left = 0 }


viewContent : Element msg
viewContent =
    column
        [ fontTypewriter
        , EF.size 16
        , paddingTop 20
        , ER.mainContent
        ]
        [ paragraph [ paddingXY 0 20 ] [ Element.text text1 ]
        , paragraph [ paddingXY 0 20 ] [ Element.text text2 ]
        , paragraph [ paddingXY 0 20 ] [ Element.text text3 ]
        ]
