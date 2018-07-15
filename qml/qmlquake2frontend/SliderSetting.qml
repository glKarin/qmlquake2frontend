import QtQuick 1.1
import com.nokia.meego 1.1

Item{
	id: root;
	objectName: "karinSliderSetting";
	property string name;
	width: parent.width;
	height: col.height;

	Column{
		id: col;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		//height: label.height + col.height;
		Row{
			width: parent.width;
			height: label.height;
			spacing: 4;
			LineText{
				id:  label;
				pixelSize: 26;
				width: parent.width - valueText.width - parent.spacing;
				style: "left";
			}
			Text{
				id: valueText;
				width: 60;
				height: label.height;
				horizontalAlignment: Text.AlignLeft;
				verticalAlignment: Text.AlignVCenter;
				font.pixelSize: constant._LabelTextSize;
				elide: Text.ElideRight;
				text: slider.value.toString();
				font.family: constant._FontFamily;
				color: constant._ItemTextColor;
			}
		}
		Column{
			id: subcol;
			width: parent.width;
			Item{
				width: parent.width;
				height: 20;
				Text{
					id: min_label;
					anchors.left: parent.left;
					anchors.leftMargin: 30;
					anchors.top: parent.top;
					anchors.bottom: parent.bottom;
					width: parent.width / 2;
					horizontalAlignment: Text.AlignLeft;
					verticalAlignment: Text.AlignVCenter;
					font.pixelSize: 20;
					elide: Text.ElideRight;
					text: slider.minimumValue.toString();
					font.family: constant._FontFamily;
					color: constant._ItemTextColor;
				}
				Text{
					id: max_label;
					anchors.right: parent.right;
					anchors.rightMargin: 30;
					anchors.top: parent.top;
					anchors.bottom: parent.bottom;
					width: parent.width / 2;
					horizontalAlignment: Text.AlignRight;
					verticalAlignment: Text.AlignVCenter;
					font.pixelSize: 20;
					elide: Text.ElideRight;
					text: slider.maximumValue.toString();
					font.family: constant._FontFamily;
					color: constant._ItemTextColor;
				}
			}
			Slider{
				id: slider;
				width: parent.width;
				anchors.horizontalCenter: parent.horizontalCenter;
				minimumValue: 0;
				maximumValue: 100;
				stepSize: 1;
				value: 1;
				valueIndicatorText: value.toString();
			}
		}
	}

	function init(setting)
	{
		if(!setting)
		{
			return;
		}
		if(setting.type !== constant._IntRangeSetting)
		{
			return;
		}

		root.name = setting.name;
		var v = setting.values[0];
		slider.minimumValue = parseInt(setting.values[1].value);
		slider.maximumValue = parseInt(setting.values[2].value);
		slider.stepSize = parseInt(setting.values[3].value);
		slider.value = parseInt(v.value);
		label.text = setting.title;
		label.info = setting.desc;
		v.valueChanged.connect(function(c){
			slider.value = parseInt(c);
		});
		slider.valueChanged.connect(function(v){
			if(slider.pressed)
			{
				frontend.setSetting(root.name, slider.value);
			}
		});
	}

	Component.onDestruction:{
		console.log("[Destroy]: " + objectName);
	}
}

