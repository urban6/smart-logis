package kr.co.shovvel.hcf.web.servlet.view;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.util.CollectionUtils;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;

public class HCFContentNegotiatingViewResolver extends ContentNegotiatingViewResolver {
	private static final Log logger = LogFactory.getLog(ContentNegotiatingViewResolver.class);
	
	public void setOrder(int order) {
		super.setOrder(order);
	}
	
	@Override
	protected List<MediaType> getMediaTypes(HttpServletRequest request) {
		// TODO Auto-generated method stub
		//return super.getMediaTypes(request);
		
		try {
			ServletWebRequest webRequest = new ServletWebRequest(request);
			List<MediaType> acceptableMediaTypes = this.getContentNegotiationManager().resolveMediaTypes(webRequest);
			//acceptableMediaTypes = (!acceptableMediaTypes.isEmpty() ? acceptableMediaTypes : Collections.singletonList(MediaType.ALL));
			List<MediaType> producibleMediaTypes = this.getProducibleMediaTypes(request);
			Set<MediaType> compatibleMediaTypes = new LinkedHashSet<MediaType>();
			for (MediaType acceptable : acceptableMediaTypes) {
				for (MediaType producible : producibleMediaTypes) {
					if (acceptable.isCompatibleWith(producible)) {
						compatibleMediaTypes.add(getMostSpecificMediaType(acceptable, producible));
					}
				}
			}
			List<MediaType> selectedMediaTypes = new ArrayList<MediaType>(compatibleMediaTypes);
			MediaType.sortBySpecificityAndQuality(selectedMediaTypes);
			if (logger.isDebugEnabled()) {
				logger.debug("Requested media types are " + selectedMediaTypes + " based on Accept header types " +
						"and producible media types " + producibleMediaTypes + ")");
			}
			return selectedMediaTypes;
		}
		catch (HttpMediaTypeNotAcceptableException ex) {
			return null;
		}
	}

	private MediaType getMostSpecificMediaType(MediaType acceptType, MediaType produceType) {
		produceType = produceType.copyQualityValue(acceptType);
		return MediaType.SPECIFICITY_COMPARATOR.compare(acceptType, produceType) < 0 ? acceptType : produceType;
	}
	
	@SuppressWarnings("unchecked")
	private List<MediaType> getProducibleMediaTypes(HttpServletRequest request) {
		Set<MediaType> mediaTypes = (Set<MediaType>)
				request.getAttribute(HandlerMapping.PRODUCIBLE_MEDIA_TYPES_ATTRIBUTE);
		if (!CollectionUtils.isEmpty(mediaTypes)) {
			return new ArrayList<MediaType>(mediaTypes);
		}
		else {
			return Collections.singletonList(MediaType.ALL);
		}
	}
}
