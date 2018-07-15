import QtQuick 1.1
import com.nokia.meego 1.1

Item{
	id: root;
	property variant model: ListModel{}
	property int currentIndex: model && model.count ? (imagePathView.currentIndex + 1) % model.count : -1;

	signal clicked(int index);

	PathView{
		id: imagePathView;
		anchors.fill: parent;
		clip: true;
		model: root.model;
		path:Path{
			startX: -imagePathView.width / 2;
			startY: imagePathView.height / 2;
			PathLine{
				x: imagePathView.model.count * imagePathView.width - imagePathView.width / 2;
				y: imagePathView.height / 2;
			}
		}
		delegate: Component{
			Item{
				width: PathView.view.width;
				height: PathView.view.height;
				Image{
					anchors.fill: parent;
					smooth: true;
					asynchronous: true;
					clip: true;
					source: model.source;
					fillMode: Image.PreserveAspectFit;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked:{
						root.clicked(index);
					}
				}
			}
		}
	}

	function prev()
	{
		imagePathView.decrementCurrentIndex();
	}

	function next()
	{
		imagePathView.incrementCurrentIndex();
	}
}

