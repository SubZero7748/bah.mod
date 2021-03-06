' Copyright (c) 2009-2012 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import BRL.Blitz
Import BRL.Keycodes

Import "../libxml.mod/src/*.h"
Import "../../pub.mod/freetype.mod/include/*.h"
Import "../regex.mod/src/*.h"
Import "../freeimage.mod/src/*.h"

?macos
Import "-framework CoreFoundation"
Import "cegui/src/implementations/mac/*.h"
?

'
Import "cegui/include/*.h"

Import "cegui/src/CEGUIAffector.cpp"
Import "cegui/src/CEGUIAnimationManager.cpp"
Import "cegui/src/CEGUIAnimationInstance.cpp"
Import "cegui/src/CEGUIAnimation.cpp"
Import "cegui/src/CEGUIAnimation_xmlHandler.cpp"
Import "cegui/src/CEGUIBase.cpp"
Import "cegui/src/CEGUIBasicInterpolators.cpp"
Import "cegui/src/CEGUIBasicRenderedStringParser.cpp"
Import "cegui/src/CEGUIBidiVisualMapping.cpp"
Import "cegui/src/CEGUIBoundSlot.cpp"
Import "cegui/src/CEGUICentredRenderedString.cpp"
Import "cegui/src/CEGUIChainedXMLHandler.cpp"
Import "cegui/src/CEGUIColour.cpp"
Import "cegui/src/CEGUIColourRect.cpp"
Import "cegui/src/CEGUIConfig_xmlHandler.cpp"
Import "cegui/src/CEGUICoordConverter.cpp"
Import "cegui/src/CEGUIDataContainer.cpp"
Import "cegui/src/CEGUIDefaultLogger.cpp"
Import "cegui/src/CEGUIDefaultRenderedStringParser.cpp"
Import "cegui/src/CEGUIDefaultResourceProvider.cpp"
Import "cegui/src/CEGUIDynamicModule.cpp"
Import "cegui/src/CEGUIEvent.cpp"
Import "cegui/src/CEGUIEventArgs.cpp"
Import "cegui/src/CEGUIEventSet.cpp"
Import "cegui/src/CEGUIEventSignal.cpp"
Import "cegui/src/CEGUIEventSignalSet.cpp"
Import "cegui/src/CEGUIExceptions.cpp"
Import "cegui/src/CEGUIFactoryModule.cpp"
Import "cegui/src/CEGUIFont_xmlHandler.cpp"
Import "cegui/src/CEGUIFont.cpp"
Import "cegui/src/CEGUIFontManager.cpp"
Import "cegui/src/CEGUIFontProperties.cpp"
Import "cegui/src/CEGUIFormattedRenderedString.cpp"
Import "cegui/src/CEGUIFreeTypeFont.cpp"
Import "cegui/src/CEGUIFribidiVisualMapping.cpp"
Import "cegui/src/CEGUIGeometryBuffer.cpp"
Import "cegui/src/CEGUIGlobalEventSet.cpp"
Import "cegui/src/CEGUIGUILayout_xmlHandler.cpp"
Import "cegui/src/CEGUIImage.cpp"
Import "cegui/src/CEGUIImageCodec.cpp"
Import "cegui/src/CEGUIImageset_xmlHandler.cpp"
Import "cegui/src/CEGUIImageset.cpp"
Import "cegui/src/CEGUIImagesetManager.cpp"
Import "cegui/src/CEGUIJustifiedRenderedString.cpp"
Import "cegui/src/CEGUIJustifiedRenderedStringWordWrapper.cpp"
Import "cegui/src/CEGUIKeyFrame.cpp"
Import "cegui/src/CEGUILeftAlignedRenderedString.cpp"
'Import "cegui/src/CEGUILinkedEvent.cpp"
Import "cegui/src/CEGUILogger.cpp"
Import "cegui/src/CEGUIMinibidiVisualMapping.cpp"
Import "cegui/src/CEGUIMouseCursor.cpp"
Import "cegui/src/CEGUINamedXMLResourceManager.cpp"
Import "cegui/src/CEGUIPCRERegexMatcher.cpp"
Import "cegui/src/CEGUIPixmapFont.cpp"
Import "cegui/src/CEGUIProperty.cpp"
Import "cegui/src/CEGUIPropertyHelper.cpp"
Import "cegui/src/CEGUIPropertySet.cpp"
'Import "cegui/src/CEGUIQuaternion.cpp"
Import "cegui/src/CEGUIRect.cpp"
Import "cegui/src/CEGUIRenderedString.cpp"
Import "cegui/src/CEGUIRenderedStringComponent.cpp"
Import "cegui/src/CEGUIRenderedStringImageComponent.cpp"
Import "cegui/src/CEGUIRenderedStringTextComponent.cpp"
Import "cegui/src/CEGUIRenderedStringWidgetComponent.cpp"
Import "cegui/src/CEGUIRenderingRoot.cpp"
Import "cegui/src/CEGUIRenderingSurface.cpp"
Import "cegui/src/CEGUIRenderingWindow.cpp"
Import "cegui/src/CEGUIRenderQueue.cpp"
Import "cegui/src/CEGUIRightAlignedRenderedString.cpp"
Import "cegui/src/CEGUIScheme_xmlHandler.cpp"
Import "cegui/src/CEGUIScheme.cpp"
Import "cegui/src/CEGUISchemeManager.cpp"
Import "cegui/src/CEGUIScriptModule.cpp"
Import "cegui/src/CEGUISize.cpp"
Import "cegui/src/CEGUIString.cpp"
Import "cegui/src/CEGUISubscriberSlot.cpp"
Import "cegui/src/CEGUISystem.cpp"
Import "cegui/src/CEGUITextUtils.cpp"
Import "cegui/src/CEGUIWindow.cpp"
Import "cegui/src/CEGUIWindowFactory.cpp"
Import "cegui/src/CEGUIWindowFactoryManager.cpp"
Import "cegui/src/CEGUIWindowManager.cpp"
Import "cegui/src/CEGUIWindowProperties.cpp"
Import "cegui/src/CEGUIWindowRenderer.cpp"
Import "cegui/src/CEGUIWindowRendererManager.cpp"
Import "cegui/src/CEGUIWindowRendererModule.cpp"
Import "cegui/src/CEGUIWRFactoryRegisterer.cpp"
Import "cegui/src/CEGUIXMLAttributes.cpp"
Import "cegui/src/CEGUIXMLHandler.cpp"
Import "cegui/src/CEGUIXMLParser.cpp"
Import "cegui/src/CEGUIXMLSerializer.cpp"
Import "cegui/src/CEGUIRenderEffectManager.cpp"
Import "cegui/src/elements/CEGUIButtonBase.cpp"
Import "cegui/src/elements/CEGUICheckbox.cpp"
Import "cegui/src/elements/CEGUICheckboxProperties.cpp"
Import "cegui/src/elements/CEGUIClippedContainer.cpp"
Import "cegui/src/elements/CEGUICombobox.cpp"
Import "cegui/src/elements/CEGUIComboboxProperties.cpp"
Import "cegui/src/elements/CEGUIComboDropList.cpp"
'Import "cegui/src/elements/CEGUIDefaultWindow.cpp"
Import "cegui/src/elements/CEGUIDragContainer.cpp"
Import "cegui/src/elements/CEGUIDragContainerProperties.cpp"
Import "cegui/src/elements/CEGUIEditbox.cpp"
Import "cegui/src/elements/CEGUIEditboxProperties.cpp"
Import "cegui/src/elements/CEGUIFrameWindow.cpp"
Import "cegui/src/elements/CEGUIFrameWindowProperties.cpp"
Import "cegui/src/elements/CEGUIGridLayoutContainer.cpp"
Import "cegui/src/elements/CEGUIGridLayoutContainerProperties.cpp"
Import "cegui/src/elements/CEGUIGroupBox.cpp"
Import "cegui/src/elements/CEGUIHorizontalLayoutContainer.cpp"
Import "cegui/src/elements/CEGUIItemEntry.cpp"
Import "cegui/src/elements/CEGUIItemEntryProperties.cpp"
Import "cegui/src/elements/CEGUIItemListBase.cpp"
Import "cegui/src/elements/CEGUIItemListBaseProperties.cpp"
Import "cegui/src/elements/CEGUIItemListbox.cpp"
Import "cegui/src/elements/CEGUIItemListboxProperties.cpp"
Import "cegui/src/elements/CEGUILayoutContainer.cpp"
Import "cegui/src/elements/CEGUIListbox.cpp"
Import "cegui/src/elements/CEGUIListboxItem.cpp"
Import "cegui/src/elements/CEGUIListboxProperties.cpp"
Import "cegui/src/elements/CEGUIListboxTextItem.cpp"
Import "cegui/src/elements/CEGUIListHeader.cpp"
Import "cegui/src/elements/CEGUIListHeaderProperties.cpp"
Import "cegui/src/elements/CEGUIListHeaderSegment.cpp"
Import "cegui/src/elements/CEGUIListHeaderSegmentProperties.cpp"
Import "cegui/src/elements/CEGUIMenubar.cpp"
Import "cegui/src/elements/CEGUIMenuBase.cpp"
Import "cegui/src/elements/CEGUIMenuBaseProperties.cpp"
Import "cegui/src/elements/CEGUIMenuItem.cpp"
Import "cegui/src/elements/CEGUIMenuItemProperties.cpp"
Import "cegui/src/elements/CEGUIMultiColumnList.cpp"
Import "cegui/src/elements/CEGUIMultiColumnListProperties.cpp"
Import "cegui/src/elements/CEGUIMultiLineEditbox.cpp"
Import "cegui/src/elements/CEGUIMultiLineEditboxProperties.cpp"
Import "cegui/src/elements/CEGUIPopupMenu.cpp"
Import "cegui/src/elements/CEGUIPopupMenuProperties.cpp"
Import "cegui/src/elements/CEGUIProgressBar.cpp"
Import "cegui/src/elements/CEGUIProgressBarProperties.cpp"
Import "cegui/src/elements/CEGUIPushButton.cpp"
Import "cegui/src/elements/CEGUIRadioButton.cpp"
Import "cegui/src/elements/CEGUIRadioButtonProperties.cpp"
Import "cegui/src/elements/CEGUIScrollablePane.cpp"
Import "cegui/src/elements/CEGUIScrollablePaneProperties.cpp"
Import "cegui/src/elements/CEGUIScrollbar.cpp"
Import "cegui/src/elements/CEGUIScrollbarProperties.cpp"
Import "cegui/src/elements/CEGUIScrolledContainer.cpp"
Import "cegui/src/elements/CEGUIScrolledContainerProperties.cpp"
Import "cegui/src/elements/CEGUIScrolledItemListBase.cpp"
Import "cegui/src/elements/CEGUIScrolledItemListBaseProperties.cpp"
Import "cegui/src/elements/CEGUISlider.cpp"
Import "cegui/src/elements/CEGUIGUISheet.cpp"
Import "cegui/src/elements/CEGUISliderProperties.cpp"
Import "cegui/src/elements/CEGUISequentialLayoutContainer.cpp"
Import "cegui/src/elements/CEGUISpinner.cpp"
Import "cegui/src/elements/CEGUISpinnerProperties.cpp"
Import "cegui/src/elements/CEGUITabButton.cpp"
Import "cegui/src/elements/CEGUITabControl.cpp"
Import "cegui/src/elements/CEGUITabControlProperties.cpp"
Import "cegui/src/elements/CEGUIThumb.cpp"
Import "cegui/src/elements/CEGUIThumbProperties.cpp"
Import "cegui/src/elements/CEGUITitlebar.cpp"
Import "cegui/src/elements/CEGUITitlebarProperties.cpp"
Import "cegui/src/elements/CEGUITooltip.cpp"
Import "cegui/src/elements/CEGUITooltipProperties.cpp"
Import "cegui/src/elements/CEGUITree.cpp"
Import "cegui/src/elements/CEGUITreeItem.cpp"
Import "cegui/src/elements/CEGUITreeProperties.cpp"
Import "cegui/src/elements/CEGUIVerticalLayoutContainer.cpp"

Import "cegui/src/falagard/CEGUIFalagard_xmlHandler.cpp"
Import "cegui/src/falagard/CEGUIFalComponentBase.cpp"
Import "cegui/src/falagard/CEGUIFalDimensions.cpp"
'Import "cegui/src/falagard/CEGUIFalEventLinkDefinition.cpp"
Import "cegui/src/falagard/CEGUIFalFrameComponent.cpp"
Import "cegui/src/falagard/CEGUIFalImageryComponent.cpp"
Import "cegui/src/falagard/CEGUIFalImagerySection.cpp"
Import "cegui/src/falagard/CEGUIFalLayerSpecification.cpp"
Import "cegui/src/falagard/CEGUIFalNamedArea.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyDefinition.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyDefinitionBase.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyInitialiser.cpp"
Import "cegui/src/falagard/CEGUIFalPropertyLinkDefinition.cpp"
Import "cegui/src/falagard/CEGUIFalSectionSpecification.cpp"
Import "cegui/src/falagard/CEGUIFalStateImagery.cpp"
Import "cegui/src/falagard/CEGUIFalTextComponent.cpp"
Import "cegui/src/falagard/CEGUIFalWidgetComponent.cpp"
Import "cegui/src/falagard/CEGUIFalWidgetLookFeel.cpp"
Import "cegui/src/falagard/CEGUIFalWidgetLookManager.cpp"
Import "cegui/src/falagard/CEGUIFalXMLEnumHelper.cpp"
'Import "cegui/src/falagard/CEGUIFalExpressionDim.cpp"
'Import "cegui/src/falagard/CEGUIFalExpressionDimParser.cpp"
'Import "cegui/src/falagard/CEGUIFalExpressionDimScanner.cpp"

'
Import "cegui/include/WindowRendererSets/Falagard/*.h"
Import "cegui/src/WindowRendererSets/Falagard/FalButton.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalDefault.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalEditbox.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalEditboxProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalFrameWindow.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalItemEntry.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalItemListbox.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalListbox.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalListHeader.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalListHeaderProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalListHeaderSegment.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalMenubar.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalMenuItem.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalModule.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalMultiColumnList.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalMultiLineEditbox.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalMultiLineEditboxProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalPopupMenu.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalProgressBar.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalProgressBarProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalScrollablePane.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalScrollbar.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalScrollbarProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalSlider.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalSliderProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalStatic.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalStaticImage.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalStaticImageProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalStaticProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalStaticText.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalStaticTextProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalSystemButton.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalTabButton.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalTabControl.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalTabControlProperties.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalTitlebar.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalToggleButton.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalTooltip.cpp"
Import "cegui/src/WindowRendererSets/Falagard/FalTree.cpp"

' xml parser
Import "cegui/include/XMLParserModules/TinyXMLParser/ceguitinyxml/*.h"
Import "cegui/src/XMLParserModules/TinyXMLParser/ceguitinyxml/tinystr.cpp"
Import "cegui/src/XMLParserModules/TinyXMLParser/ceguitinyxml/tinyxmlparser.cpp"
Import "cegui/src/XMLParserModules/TinyXMLParser/ceguitinyxml/tinyxml.cpp"
Import "cegui/src/XMLParserModules/TinyXMLParser/ceguitinyxml/tinyxmlerror.cpp"

Import "cegui/include/XMLParserModules/TinyXMLParser/*.h"
Import "cegui/src/XMLParserModules/TinyXMLParser/CEGUITinyXMLParser.cpp"
Import "cegui/src/XMLParserModules/TinyXMLParser/CEGUITinyXMLParserModule.cpp"


' freeimage
Import "cegui/include/ImageCodecModules/FreeImageImageCodec/*.h"
Import "cegui/src/ImageCodecModules/FreeImageImageCodec/CEGUIFreeImageImageCodec.cpp"
Import "cegui/src/ImageCodecModules/FreeImageImageCodec/CEGUIFreeImageImageCodecModule.cpp"

?macos
Import "cegui/src/implementations/mac/macPlugins.cpp"
?

Import "*.h"
Import "glue.cpp"
