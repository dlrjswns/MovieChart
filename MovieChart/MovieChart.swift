//
//  MovieChart.swift
//  MovieChart
//
//  Created by 이건준 on 2021/10/09.
//

import UIKit
import CardSlider

struct Item:CardSliderItem{
    var image: UIImage
    
    var rating: Int?
    
    var title: String
    
    var subtitle: String?
    
    var description: String?
}
class MovieChart:UIViewController, CardSliderDataSource{
    var item = [Item]()
    
    lazy var titleImageView:UIImageView={
       let imageView = UIImageView()
        imageView.image = UIImage(named: "title.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var chartButton:UIButton={
        let button = UIButton(type: .system)
        button.setTitle("차트보기", for: .normal)
        button.addTarget(self, action: #selector(makeChart), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addItem()
        configure()
        callMovieAPI()
    }
    
   @objc func makeChart(){
        let vc = CardSliderViewController.with(dataSource: self)
        vc.title = "Movie Chart"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func callMovieAPI(){
        let urI = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        
        let urL:URL! = URL(string: urI)
        let apiData = try! Data(contentsOf: urL)
        
        do{
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for r in movie{
                let row = r as! NSDictionary
                let urI = row["thumbnailImage"]
                let urL:URL! = try! URL(string: urI as! String)
                let imgData = try! Data(contentsOf: urL)
                
                item.append(Item(image: UIImage(data: imgData)!, rating: nil, title: row["title"] as! String, subtitle: row["genreNames"] as! String, description: nil))
            }
        }catch{}
    }
    
    func addItem(){
//        item.append(Item(image: UIImage(named: "image4.jpeg")!, rating: nil, title: "베놈 2: 렛 데어 비 카니지", subtitle: "평점 8.0 예매율 44.0%", description:
//                         """
//                         히어로의 시대는 끝났다
//                         `베놈`과 완벽한 파트너가 된 `에디 브록`(톰 하디) 앞에`클리터스캐서디`(우디해럴슨)가`카니지`로 등장,
//                         앞으로 닥칠 대혼돈의 세상을 예고한다.
//                         대혼돈의 시대가 시작되고,
//                         악을 악으로 처단할 것인가
//                         """))
//
//        item.append(Item(image: UIImage(named: "image1.jpeg")!, rating: nil, title: "007 노 타임 투 다이", subtitle: "평점 6.2 예매율 16.7%", description:
//                            """
//                            가장 강력한 운명의 적의 등장으로
//                            죽음과 맞닿은 작전을 수행하게 된
//                            제임스 본드의 마지막 미션을 그린 액션 블록버스터
//                            """))
//
//        item.append(Item(image: UIImage(named: "image5.jpeg")!, rating: nil, title: "듄", subtitle: "평점 8.1 예매율 10.8%", description:
//                         """
//                            “듄을 지배하는 자가 우주를 지배한다!”
//
//                         10191년, 아트레이데스 가문의 후계자인
//                         폴(티모시 샬라메)은 시공을 초월한 존재이자
//                         전 우주를 구원할 예지된 자의 운명을 타고났다.
//                         그리고 어떤 계시처럼 매일 꿈에서
//                         아라키스 행성에 있는 한 여인을 만난다.
//                         모래언덕을 뜻하는 '듄'이라 불리는 아라키스는
//                         물 한 방울 없는 사막이지만
//                         우주에서 가장 비싼 물질인 신성한 환각제
//                         스파이스의 유일한 생산지로 이를 차지하기 위한
//                         전쟁이 치열하다.
//                         황제의 명령으로 폴과 아트레이데스 가문은
//                         죽음이 기다리는 아라키스로 향하는데…
//
//                         위대한 자는 부름에 응답한다, 두려움에 맞서라, 이것은 위대한 시작이다!
//                         """))
//
//        item.append(Item(image: UIImage(named: "image2.jpeg")!, rating: nil, title: "보이스", subtitle: "평점 8.4 예매율 3.7%", description:
//            """
//            단 한 통의 전화!
//            걸려오는 순간 걸려들었다!
//
//            부산 건설현장 직원들을 상대로 걸려온 전화 한 통.
//            보이스피싱 전화로 인해 딸의 병원비부터 아파트 중도금까지,
//            당일 현장에서는 수많은 사람들이 목숨 같은 돈을 잃게 된다.
//
//            현장작업반장인 전직형사 서준(변요한)은 가족과 동료들의
//            돈 30억을 되찾기 위해
//            보이스피싱 조직을 추적하기 시작한다.
//
//            마침내 중국에 위치한 본거지 콜센터 잠입에 성공한 서준,
//            개인정보확보, 기획실 대본입고, 인출책 섭외, 환전소 작업,
//            대규모 콜센터까지!
//            체계적으로 조직화된 보이스피싱의 스케일에 놀라고,
//            그곳에서 피해자들의 희망과 공포를 파고드는 목소리의 주인공이자
//            기획실 총책 곽프로(김무열)를 드디어 마주한다.
//
//            그리고 그가 300억 규모의 새로운 총력전을 기획하는 것을 알게 되는데..
//
//            상상이상으로 치밀하게 조직화된 보이스피싱의 실체!
//            끝까지 쫓아 반드시 되찾는다!
//            """))
//
//        item.append(Item(image: UIImage(named: "image10.png")!, rating: nil, title: "F20", subtitle: "평점 2.7 예매율 3.2%", description:
//                         """
//                         나의 삶은 모든 것이 완벽했다
//
//                         어디에 내놔도 자랑스러운 아들을 둔 엄마 `애란`은
//                         군 생활을 떠났던 아들 `도훈`에게
//                         조현병이 발병했다는 충격적인 소식을 듣게 된다.
//
//                         완벽했던 자신의 일상을 빼앗길까 두려운 `애란`은
//                         아들의 병을 숨긴 채 살아가기로 결심하고
//
//                         그러나, 순조로울 것만 같았던 그녀의 삶에
//                         유일한 비밀을 알고 있는 `경화`가 나타나자
//                         `애란`의 불안은 점점 광기로 변해가는데…
//
//                         2021년, 가장 날카롭고 충격적인 영화가 온다!
//                         """))
//
//        item.append(Item(image: UIImage(named: "image3.jpeg")!, rating: nil, title: "기적", subtitle: "평점 8.8 예매율 2.4%", description:
//                         """
//                         오갈 수 있는 길은 기찻길밖에 없지만
//                         정작 기차역은 없는 마을.
//                         오늘부로 청와대에 딱 54번째 편지를
//                         보낸 ‘준경’(박정민)의 목표는 단 하나!
//                         바로 마을에 기차역이 생기는 것이다.
//
//                         기차역은 어림없다는 원칙주의 기관사
//                         아버지 ‘태윤’(이성민)의 반대에도
//                         누나 ‘보경’(이수경)과 마을에 남는 걸 고집하며
//                         왕복 5시간 통학길을 오가는 ‘준경’.
//                         그의 엉뚱함 속 비범함을 단번에 알아본
//                         자칭 뮤즈 ‘라희’(임윤아)와 함께
//                         설득력 있는 편지쓰기를 위한 맞춤법 수업,
//                         유명세를 얻기 위한 장학퀴즈 테스트,
//                         대통령배 수학경시대회 응시까지!
//                         오로지 기차역을 짓기 위한
//                         ‘준경’만의 노력은 계속되는데...!
//
//                         포기란 없다
//                         기차가 서는 그날까지!
//                         """))
    }
    
    func configure(){
        view.backgroundColor = .tertiarySystemGroupedBackground
        
        view.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(chartButton)
        chartButton.translatesAutoresizingMaskIntoConstraints = false
        chartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartButton.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 20).isActive = true
    }
    
    func item(for index: Int) -> CardSliderItem {
        return item[index]
    }
    
    func numberOfItems() -> Int {
        return item.count
    }
}
