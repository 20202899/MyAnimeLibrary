//
//  Anime.swift
//  Domain
//
//  Created by Carlos Silva on 20/02/23.
//

import Foundation

public struct Animes: Decodable {
    public let data: [Anime]
    
    public init(data: [Anime]) {
        self.data = data
    }
}

public struct Anime: Decodable {
    public let id: String
    public let type: String
    public let links: AnimeLinks
    public let attributes: Attributes
    public let relationships: Relationships
    public let title: String
    
    enum CodingKeys: CodingKey {
        case id
        case type
        case links
        case attributes
        case relationships
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.links = try container.decode(AnimeLinks.self, forKey: .links)
        self.attributes = try container.decode(Attributes.self, forKey: .attributes)
        self.relationships = try container.decode(Relationships.self, forKey: .relationships)
        
        let titles = attributes.titles
        self.title = titles.en ?? titles.en_jp ?? titles.en_cn ?? titles.ja_jp ?? titles.zh_cn ?? String()
    }
    
    public init(id: String, type: String, links: AnimeLinks, attributes: Attributes, relationships: Relationships) {
        self.id = id
        self.type = type
        self.links = links
        self.attributes = attributes
        self.relationships = relationships
        
        let titles = attributes.titles
        self.title = titles.en ?? titles.en_jp ?? titles.en_cn ?? titles.ja_jp ?? titles.zh_cn ?? String()
    }
}

public struct Attributes: Decodable {
    public let createdAt: String
    public let updatedAt: String
    public let slug: String
    public let synopsis: String?
    public let description: String?
    public let coverImageTopOffset: Int
    public let titles: Titles
    public let canonicalTitle: String
    public let abbreviatedTitles: [String?]
    public let averageRating: String?
    public let ratingFrequencies: [String: String]
    public let userCount: Int
    public let favoritesCount: Int
    public let startDate: String
    public let endDate: String?
    public let popularityRank: Int
    public let ratingRank: Int?
    public let ageRating: String?
    public let ageRatingGuide: String?
    public let subtype: String
    public let status: String
    public let tba: String?
    public let posterImage: PosterImage
    public let coverImage: CoverImage?
    public let episodeCount: Int?
    public let episodeLength: Int?
    public let totalLength: Int?
    public let youtubeVideoId: String?
    public let showType: String
    public let nsfw: Bool
    
    public init(
        createdAt: String,
        updatedAt: String,
        slug: String,
        synopsis: String?,
        description: String?,
        coverImageTopOffset: Int,
        titles: Titles,
        canonicalTitle: String,
        abbreviatedTitles: [String?],
        averageRating: String?,
        ratingFrequencies: [String: String],
        userCount: Int,
        favoritesCount: Int,
        startDate: String,
        endDate: String?,
        popularityRank: Int,
        ratingRank: Int?,
        ageRating: String?,
        ageRatingGuide: String?,
        subtype: String,
        status: String,
        tba: String?,
        posterImage: PosterImage,
        coverImage: CoverImage?,
        episodeCount: Int?,
        episodeLength: Int?,
        totalLength: Int?,
        youtubeVideoId: String?,
        showType: String,
        nsfw: Bool
    ) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.slug = slug
        self.synopsis = synopsis
        self.description = description
        self.coverImageTopOffset = coverImageTopOffset
        self.titles = titles
        self.canonicalTitle = canonicalTitle
        self.abbreviatedTitles = abbreviatedTitles
        self.averageRating = averageRating
        self.ratingFrequencies = ratingFrequencies
        self.userCount = userCount
        self.favoritesCount = favoritesCount
        self.startDate = startDate
        self.endDate = endDate
        self.popularityRank = popularityRank
        self.ratingRank = ratingRank
        self.ageRating = ageRating
        self.ageRatingGuide = ageRatingGuide
        self.subtype = subtype
        self.status = status
        self.tba = tba
        self.posterImage = posterImage
        self.coverImage = coverImage
        self.episodeCount = episodeCount
        self.episodeLength = episodeLength
        self.totalLength = totalLength
        self.youtubeVideoId = youtubeVideoId
        self.showType = showType
        self.nsfw = nsfw
    }
}

public struct CoverImage: Decodable {
    public let tiny: String?
    public let small: String?
    public let large: String?
    public let original: String?
    public let meta: Meta?
    
    public init(tiny: String?, small: String?, large: String?, original: String?, meta: Meta?) {
        self.tiny = tiny
        self.small = small
        self.large = large
        self.original = original
        self.meta = meta
    }
}

public struct PosterImage: Decodable {
    public let tiny: String
    public let large: String
    public let small: String
    public let medium: String
    public let original: String
    public let meta: Meta
    
    public init(tiny: String, large: String, small: String, medium: String, original: String, meta: Meta) {
        self.tiny = tiny
        self.large = large
        self.small = small
        self.medium = medium
        self.original = original
        self.meta = meta
    }
}

public struct Meta: Decodable {
    public let dimensions: Dimensions
    
    public init(dimensions: Dimensions) {
        self.dimensions = dimensions
    }
}

public struct Dimensions: Decodable {
    public let tiny: Large?
    public let large: Large?
    public let small: Large?
    public let medium: Large?
    
    public init(tiny: Large?, large: Large?, small: Large?, medium: Large?) {
        self.tiny = tiny
        self.large = large
        self.small = small
        self.medium = medium
    }
}

public struct Large: Decodable {
    public let width: Int?
    public let height: Int?
    
    public init(width: Int?, height: Int?) {
        self.width = width
        self.height = height
    }
}

public struct Titles: Decodable {
    public let en: String?
    public let en_jp: String?
    public let ja_jp: String?
    public let en_cn: String?
    public let zh_cn: String?
    
    public init(en: String?, en_jp: String?, ja_jp: String?, en_cn: String?, zh_cn: String?) {
        self.en = en
        self.en_jp = en_jp
        self.ja_jp = ja_jp
        self.en_cn = en_cn
        self.zh_cn = zh_cn
    }
    
    public func toName() -> String {
        return en ?? en_jp ?? ja_jp ?? en_cn ?? zh_cn ?? String()
    }
}

public struct AnimeLinks: Decodable {
    public let _self: String
    
    enum CodingKeys: String, CodingKey {
        case _self = "self"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._self = try container.decode(String.self, forKey: ._self)
    }
}

public struct Relationships: Decodable {
    public let genres: AnimeCharacters
    public let categories: AnimeCharacters
    public let castings: AnimeCharacters
    public let installments: AnimeCharacters
    public let mappings: AnimeCharacters
    public let reviews: AnimeCharacters
    public let mediaRelationships: AnimeCharacters
    public let characters: AnimeCharacters
    public let staff: AnimeCharacters
    public let productions: AnimeCharacters
    public let quotes: AnimeCharacters
    public let episodes: AnimeCharacters
    public let streamingLinks: AnimeCharacters
    public let animeProductions: AnimeCharacters
    public let animeCharacters: AnimeCharacters
    public let animeStaff: AnimeCharacters
}

public struct AnimeCharacters: Decodable {
    public let links: AnimeCharactersLinks
}

public struct AnimeCharactersLinks: Decodable {
    public let _self: String
    public let related: String
    
    enum CodingKeys: String, CodingKey {
        case _self = "self"
        case related = "related"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._self = try container.decode(String.self, forKey: ._self)
        self.related = try container.decode(String.self, forKey: .related)
    }
}
